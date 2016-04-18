# Installation

#### Integration with Lilypond installation

It is quite complex to integrate these programs with a user's lilypond
installation, because in general the location of the lilypond install is
unable to be determined programatically, because lilypond may or may not be
installed with a package manager, or there may be multiple versions of
lilypond existing on the system. It is preferable to use package managers to
install code sets, and these are strictly non-interactive tools, by tradition
and convention, so the installer cannot interactively ask for the lilypond
location. Because of this, the code is installed in the usual system locations
(/usr/local and so on).

#### Scheme code

The code uses some locally developed Scheme modules. Since Guile code can't
easily be packaged into a single executable bundle, the modules need to be
placed in known location and the scripts adjust the Guile load path
accordingly. While this may be inconvenient, lilypond does the same thing. But
since this code is not yet part of lilypond core, and may never be, it is not
appropriate to include the local modules in the lilypond core scheme module
area. The Scheme modules used by the code are installed in a library area
under the system install location for the package.

#### Packages

The code is installed with the RPM package manager on rpm based systems. A deb
package is in the works. A Mac installer also.


#### Prerequisites

Because the code will be installed into the normal system locations, there is
a dependency on guile 1.8. This needs to be installed.

#### RPM based systems

> $ sudo rpm --install lys-0.1-1.rpm

Installs to /usr/local.

This is a relocatable package in case you want it elsewhere:

> $ sudo rpm --install --prefix=\<location\> lys-0.1-1.rpm

#### DEB based systems

Coming to a computer near you soon.

#### Mac OS X

Soon.




