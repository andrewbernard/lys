# Makefile for lys, a lilypond compile server

# This makefile is used for the purpose of building packages for RPM and DEB
# systems, not for direct installation into the filesystem. It could be used
# that way, but this would violate the spirit and policy of package based Linux
# systems.

# Since these programs are scripts, there is nothing to actually build from
# code.

# This is a standard makefile with standard targets for installation. But is is
# intended purely for building packages. Running make build-deb will build a
# debian package. Running make build-rpm will build an RPM package.

# Debian version

# package name
PACKAGE = lys

prefix = /usr/share/$(PACKAGE)
exec_prefix = $(prefix)
bindir = $(exec_prefix)/bin
libdir = $(prefix)/lib

# code version
VERSION = 0.1

# DEB distribution file
DIST_FILE = $(PACKAGE)_$(VERSION).orig.tar.xz

# DEB distribution dir
DIR = $(PACKAGE)-$(VERSION)

# RPM distribution file
DIST_FILE_RPM = $(PACKAGE)-$(VERSION).tar.xz

# RPM distribution dir
DIR_RPM = $(PACKAGE)-$(VERSION)


PROGS = lys \
	lys-server \
	lyc \
	lyc-client

SCHEME_MODULES_DIR = scm

all:
	@echo nothing to do

install:
	@echo install programs
	cp $(PROGS) $(DESTDIR)$(bindir)
	@echo install scheme modules
	cp -r $(SCHEME_MODULES_DIR) $(DESTDIR)$(libdir)

# DEB package
dist: $(DIST_FILE)
	@echo $(DIST_FILE) up to date

$(DIST_FILE): $(PROGS) $(SCHEME_MODULES)
	mkdir -p $(DIR)
	cp -r $(PROGS) $(DIR)
	cp -r $(SCHEME_MODULES_DIR) $(DIR)
	cp Makefile $(DIR)
	tar cvf $(DIST_FILE) --xz $(DIR)

distclean:
	rm -rf $(DIR)
	rm -f $(DIST_FILE)

# build DEB package
build-deb: dist
	tar xvf $(DIST_FILE)
	ls -l $(DIST_FILE)
	cp -r debian $(DIR)
	cd $(DIR); debuild -us -uc

build-deb-clean:
	rm -f *.build *.changes *.dsc *.deb *.debian.tar.xz

# RPM package
RPMBUILD = $(shell pwd)/rpmbuild

dist-rpm: $(DIST_FILE_RPM)
	@echo $(DIST_FILE_RPM) up to date

$(DIST_FILE_RPM): $(PROGS) $(SCHEME_MODULES)
	mkdir -p $(DIR_RPM)
	cp -r $(PROGS) $(DIR)
	cp -r $(SCHEME_MODULES_DIR) $(DIR)
	tar cvf $(DIST_FILE_RPM) --xz $(DIR)

distclean-rpm:
	rm -rf $(DIR)
	rm -f $(DIST_FILE_RPM)
	@echo more to do later

# build RPM package
build-rpm: dist-rpm
	@echo building RPM
	cp $(DIST_FILE_RPM) rpmbuild/SOURCES
	rpmbuild --define "_topdir $(RPMBUILD)" -ba rpmbuild/SPECS/lys.spec
	@echo "=> RPM file: "`realpath rpmbuild/RPMS/noarch/lys*.rpm`


clean: build-deb-clean

realclean: clean distclean distclean-rpm
