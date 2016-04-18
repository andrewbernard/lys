# Makefile for lys, the lilypond compile server

# Makes a compressed tar file for use in building an RPM package.

# code version
VERSION = 0.1

# rpm package version
RELEASE = 1

# output file
OUT = lys-$(VERSION)-$(RELEASE).tgz

FILES = lys \
	server \
	lyc

all: $(OUT)

$(OUT): $(FILES)
	tar cvzf $(OUT) $(FILES)
clean:
	rm -f $(OUT)


