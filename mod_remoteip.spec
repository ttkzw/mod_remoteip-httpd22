%{!?_httpd_apxs: %{expand: %%global _httpd_apxs %%{_sbindir}/apxs}}

Name:           mod_remoteip
Version:        __VERSION__
Release:        1%{?dist}__EXTRAREV__
Summary:        Set remote IP from headers, backported for Apache HTTPD 2.2.x
Group:          System Environment/Daemons
License:        ASL 2.0
URL:            https://github.com/ttkzw/mod_remoteip-httpd22
Source0:        %{name}-%{version}.tar.gz
BuildRoot:      %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)

BuildRequires:  httpd-devel >= 2.2.0, make, gcc

%description
Configuration see http://httpd.apache.org/docs/2.4/mod/mod_remoteip.html

Backport by Takashi Takizawa <taki@cyber.email.ne.jp>


%prep
%setup -q -n %{name}-%{version}

%build
make

%install
rm -rf %{buildroot}
install -Dpm 755 .libs/mod_remoteip.so %{buildroot}%{_libdir}/httpd/modules/mod_remoteip.so

%clean
rm -rf %{buildroot}


%files
%defattr(-,root,root,-)
%doc mod_remoteip.conf README LICENSE
%{_libdir}/httpd/modules/*