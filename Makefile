# Makefile for lys, a lilypond compile server

# Makes a compressed tar file for use in building an RPM package.

# code version
VERSION = 0.1

# output file
OUT = lys-$(VERSION).tgz

FILES = lys \
	lys-server \
	lyc \
	lyc-client \
	modules

RPM-SPEC = rpm/lys.spec

DIR = lys-$(VERSION)

RPM-SPEC-DIR = $(HOME)/rpmbuild/SPECS
RPM-INSTALL-DIR = $(HOME)/rpmbuild/SOURCES

all: $(OUT)

$(OUT): $(FILES)
	mkdir -p $(DIR)
	cp -r $(FILES) $(DIR)
	tar cvzf $(OUT) $(DIR)

# rpm install
install: $(OUT)
	cp $(OUT) $(RPM-INSTALL-DIR)
	cp $(RPM-SPEC) $(RPM-SPEC-DIR)

clean:
	rm -f $(OUT)
	rm -rf $(DIR)
