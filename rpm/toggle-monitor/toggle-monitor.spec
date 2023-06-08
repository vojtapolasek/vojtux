Name:     toggle-monitor
Version:  1
Release:  1
Summary:  Script to turn monitor on and off
License:  Public Domain

Requires: xrandr

SOURCE0:  monitor-toggle
SOURCE1:  10-keybindings-toggle-monitor

%description
RPM package with toggle-monitor script

%prep

%build

%install
install -d %{buildroot}%{_bindir}
install -m 755 %{SOURCE0} %{buildroot}%{_bindir}/monitor-toggle
install -d %{buildroot}%{_sysconfdir}/dconf/db/local.d
install %{SOURCE1} %{buildroot}%{_sysconfdir}/dconf/db/local.d/10-keybindings-toggle-monitor

%files
%{_bindir}/monitor-toggle
%{_sysconfdir}/dconf/db/local.d/10-keybindings-toggle-monitor

%changelog
* Thu Jun 08 2023 Konstantin Kuminsky <k.k@redhat.com> - 1-1
- First toggle-monitor package
