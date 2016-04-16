# lys
## A lilypond compile server

This is an experimental client-server for compiling
[lilypond](http://www.lilypond.org) source files. The lilypond program runs
under the server listening for TCP client connections from clients which
submit the name of a lilypond source code file. The server compiles the file
in the already running instance of lilypond, saving the overhead of starting
up lilypond. This can result in considerable time savings for small code
fragments, speeding the development process.

While the time saving for larger lilypond source code files may be small as a
fraction of the overall time taken to compile, this server has other
anticipated uses, so this is not necessarily the main point.

Code is experimental at this point.

Presently the code is only intended for Linux systems.


## Usage
The system consists of a server program and a client program.

#### Server

To start the server run:

> lys

At present, while under development, the server runs in the foreground. Later
it will have the capability to run as a fully detached daemon.

The server runs continously and accepts requests from clients and is able to
process multiple requests in parallel, up to the limit of the socket channel
listener. There is no need to wait for one job to finish before submitting
another request.

#### Client

To use the client:

> lyc file.ly

Output will be produced in the directory the client is run from.

## Installation
Refer to [Installation](Installation.md).

## Notes
This code has been developed under lilypond 2.19.39. Earlier versions have not
been tested.

#### Server
The server must be run under lilypond, although it is principally guile Scheme
code. For convenience, a simple shell script wrapper is provided.

The TCP port used is 12000. Later the option to specify a port will be added.

#### Client
The client is written entirely in Scheme. Because lilypond is currently
restricted to using guile 1.8, this is guile 1.8 code. Using guile 2 will not
work. Ensure that you have guile 1.8 installed and in your executable search
path ahead of any guile 2 versions.

As at today 16 April 2016, the client does not yet support the lilypond
command line options. Doing this turns out to be somewhat complex, and the
code is being written but not ready yet. Ultimately one will be able to pass
all the lilypond command line options to the client and have the server honour
them in the generated output. This especially applies to include paths, which
is a non trivial problem (but solved by my flatten-ly utility).

#### Development
Refer to [Development Notes](Development-Notes.md) for technical discussion of current issues.

See [TODO](TODO.md) for current status and topics.

The Guile 1.8 reference manual is
[here](https://www.gnu.org/software/guile/docs/docs-1.8/guile-ref/).

#### Testing
The code has been tested under openSUSE Leap 42.1 Linux.

## Author
Written by Andrew Bernard.

With thanks to Sharon Rosner and Urs Liska.



