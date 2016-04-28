#
# spec file for package lys

# See also http://en.opensuse.org/openSUSE:Specfile_guidelines

Name:           lys
Version:        0.1
Release:        1
Summary:        Lilypond compile client/server
License:        GPL     
Source0:        %{name}-%{version}.tgz
BuildArch:      noarch
Prefix:         /usr/local

%description
Lys is a compile server for use with the lilypond open source music engraving
software platform.

%prep
%autosetup

# no build step

%install
mkdir -p %{buildroot}/usr/local/bin
mkdir -p %{buildroot}/usr/local/share/lys/bin
mkdir -p %{buildroot}/usr/local/share/lys/lib/scm/local

cp %{_builddir}/%{name}-%{version}/lyc %{buildroot}/usr/local/share/lys/bin
cp %{_builddir}/%{name}-%{version}/lyc-client %{buildroot}/usr/local/share/lys/bin
cp %{_builddir}/%{name}-%{version}/lys %{buildroot}/usr/local/share/lys/bin
cp %{_builddir}/%{name}-%{version}/lys-server %{buildroot}/usr/local/share/lys/bin
cp %{_builddir}/%{name}-%{version}/modules/local/* %{buildroot}/usr/local/share/lys/lib/scm/local

%files
/usr/local/share/lys/bin/*
/usr/local/share/lys/lib/scm/local/*

%post
# create symlinks in /usr/local/bin. don't install there directly. cleaner.
ln -sf /usr/local/share/lys/bin/lyc /usr/local/bin/lyc
ln -sf /usr/local/share/lys/bin/lys /usr/local/bin/lys

%postun
# remove symlinks
rm -f /usr/local/bin/lyc
rm -f /usr/local/bin/lys

%changelog
* Mon Apr 18 2016 Andrew Bernard <andrew.bernard@gmail.com>
- Initial RPM build.


