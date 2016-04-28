# RPM spec file for package lys
# openSUSE specific

Name:           lys
Version:        0.1
Release:        1
Summary:        Lilypond compile client/server
License:        GPL-2.0+
URL:            https://github.com/andrewbernard/lys/releases/tag/v0.1-alpha
Source0:        %{name}-%{version}.tar.xz
BuildArch:      noarch
Requires:       guile1
Prefix:         /usr/share

%description
Lys is a compile server for use with the lilypond open source music engraving
software platform.

%prep
%autosetup

# no build step

%install
mkdir -p %{buildroot}/usr/share/bin
mkdir -p %{buildroot}/usr/share/lys/bin
mkdir -p %{buildroot}/usr/share/lys/lib/scm/local

cp %{_builddir}/%{name}-%{version}/lyc %{buildroot}/usr/share/lys/bin
cp %{_builddir}/%{name}-%{version}/lyc-client %{buildroot}/usr/share/lys/bin
cp %{_builddir}/%{name}-%{version}/lys %{buildroot}/usr/share/lys/bin
cp %{_builddir}/%{name}-%{version}/lys-server %{buildroot}/usr/share/lys/bin
cp %{_builddir}/%{name}-%{version}/scm/local/* %{buildroot}/usr/share/lys/lib/scm/local

%files
/usr/share/lys/bin/*
/usr/share/lys/lib/scm/local/*

%post
# create symlinks in /usr/local/bin. don't install there directly. cleaner.
#ln -sf /usr/local/share/lys/bin/lyc /usr/local/bin/lyc
#ln -sf /usr/local/share/lys/bin/lys /usr/local/bin/lys

%postun
# remove symlinks
#rm -f /usr/local/bin/lyc
#rm -f /usr/local/bin/lys

%changelog
* Mon Apr 18 2016 Andrew Bernard <andrew.bernard@gmail.com> 0.1
- Initial RPM build.
