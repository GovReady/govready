%define proj govready
Name:           %{proj}
Version:        0.6.0
Release:        1%{?dist}
Summary:        Software audit and compliance for developers
Group:          Utilities/Security
License:        Apache 2.0
URL:            http://www.gitmachines.com
Prefix:         /opt
BuildArch:      noarch
#BuildRoot:      %{_tmppath}/%{name}-RPM_BUILD_ROOT
Source0:        %{proj}-%{version}.tar.gz
Requires:       epel-release >= 6-8,openscap,scap-security-guide,nss >= 3.15.3

%description
Govready package

%install
rm -rf ${RPM_BUILD_ROOT}
install -m 0755 -d ${RPM_BUILD_ROOT}/opt/govready
#install -m 0755 {scripts,prototypes,templates} ${RPM_BUILD_ROOT}/opt/%{proj}/
# sloppy
cp -r * ${RPM_BUILD_ROOT}/opt/%{proj}/
rm -f ${RPM_BUILD_ROOT}/%{proj}.spec

%prep
%setup -q %{proj}

%clean
rm -rf ${RPM_BUILD_ROOT}

%build

%files
%dir /opt/%{proj}
%defattr(-,root,root,-)
%doc README.md
%doc docs/*
/opt/%{proj}/*

%post

%changelog
* Sat Jan 17 2015 Devon Kim <djk29a at gmail dot com> 0.6.0-1
- Initial RPM
