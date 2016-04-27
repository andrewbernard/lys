# Makefile for lys, a lilypond compile server

# Uses GNU make.

# Makes a compressed tar file for use in building a DEB package. Since
# these are interpreted scripts, there is no code to build.

# code version
VERSION = 0.1

# output file
OUT = lys_$(VERSION).orig.tar.xz

FILES = lys \
	lys-server \
	lyc \
	lyc-client \
	modules

DIR = lys-$(VERSION)

all: $(OUT)

$(OUT): $(FILES)
	mkdir -p $(DIR)
	cp -r $(FILES) $(DIR)
	tar cvf $(OUT) --xz $(DIR)

clean:
	rm -f $(OUT)
	rm -rf $(DIR)
