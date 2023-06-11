Name:     vojtux-settings
Version:  1
Release:  1
Summary:  Settings for Vojtux
License:  Public Domain

%description
RPM package with settings for Vojtux

%prep

%build

%install
install -d %{buildroot}%{_sysconfdir}/dconf/db/local.d
install 01-accessibility %{buildroot}%{_sysconfdir}/dconf/db/local.d/01-accessibility
install 02-panel %{buildroot}%{_sysconfdir}/dconf/db/local.d/02-panel
install 03-keybindings %{buildroot}%{_sysconfdir}/dconf/db/local.d/03-keybindings

%files
%{_sysconfdir}/dconf/db/local.d/01-accessibility
%{_sysconfdir}/dconf/db/local.d/02-panel
%{_sysconfdir}/dconf/db/local.d/03-keybindings

%changelog
* Sat Jun 10 2023 Konstantin Kuminsky <k.k@redhat.com> - 1-1
- First vojtux-settings package
