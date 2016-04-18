#### Development Notes

#### Server

The server will be fully daemonised shortly.

#### Client
##### Lilypond options

Lilypond annoyingly has two distinct types of options, the standard -- style
options and a set starting with -d (the so-called advanced options). Because
we effectively have to rewrite the lilypond command line option parsing to
make this system work, this introduces a lot of (unnecesary) difficulties. I
am working on this at the moment. I can see why lilypond may have developed
two partioned option spaces, but it is really unecessary in my opinion, but
obviously can never be changed.

The client option syntax will be rationalised and not be an exact copy of how
lilypond specifies options. The client is not meant to be an exact lilypond
clone or substitute.

##### Include paths
I have a Scheme utility that takes a lilypond command and flattens the
included files into a single lilypond source file. I shall add the code for
this to the client, which solves the include path problem. [In progress].



