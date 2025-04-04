Name:     vojtux-settings
Version:  1
Release:  4%{?dist}
Summary:  Settings for Vojtux
License:  Public Domain

SOURCE1:  01-accessibility
SOURCE2:  02-panel
SOURCE3:  03-keybindings

%description
RPM package with settings for Vojtux

%prep

%build

%install
install -d %{buildroot}%{_sysconfdir}/dconf/db/distro.d
install  %{SOURCE1} %{buildroot}%{_sysconfdir}/dconf/db/distro.d/01-accessibility
install  %{SOURCE2} %{buildroot}%{_sysconfdir}/dconf/db/distro.d/02-panel
install  %{SOURCE3} %{buildroot}%{_sysconfdir}/dconf/db/distro.d/03-keybindings

%post
dconf update

%postun
dconf update

%files
%{_sysconfdir}/dconf/db/distro.d/01-accessibility
%{_sysconfdir}/dconf/db/distro.d/02-panel
%{_sysconfdir}/dconf/db/distro.d/03-keybindings

%changelog
* Fri Apr 04 2025 vojtapolasek <krecoun@gmail.com> - 1-4
- remove most of Mate panel settings overrides, overriding only minimal set of settings

* Fri Dec 20 2024 Vojtech Polasek <vpolasek@redhat.com> - 1-3
- change entry names not to occupy names reserved for user-created keyboard shortcuts
- remove lios keyboard shortcut
- update keybindings related to audio volume to use wpctl

* Mon Sep 18 2023 Vojtech Polasek <vpolasek@redhat.com> - 1-2
- update dconf database in the post phase
- install files into distro.d directory as we are a package
- update dconf database after package removal


* Sat Jun 10 2023 Konstantin Kuminsky <k.k@redhat.com> - 1-1
- First vojtux-settings package
