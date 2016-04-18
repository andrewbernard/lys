# Makefile for lys, the lilypond compile server

# Makes a compressed tar file for use in building an RPM package.

# code version
VERSION = 0.1

# output file
OUT = lys-$(VERSION).tgz

FILES = lys \
	server \
	lyc

DIR = lys-$(VERSION)

RPM-INSTALL = $(HOME)/rpmbuild/SOURCES

all: $(OUT)

$(OUT): $(FILES)
	mkdir -p $(DIR)
	cp $(FILES) $(DIR)
	tar cvzf $(OUT) $(DIR)

# rpm install
install: $(OUT)
	cp $(OUT) $(RPM-INSTALL)

clean:
	rm -f $(OUT)
	rm -rf $(DIR)




