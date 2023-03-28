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

%install
install -d %{buildroot}/usr/bin
install -m 755 %{SOURCE0} %{buildroot}/usr/bin/monitor-toggle
install -d %{buildroot}/etc/dconf/db/local.d
install %{SOURCE1} %{buildroot}/etc/dconf/db/local.d/10-keybindings-toggle-monitor

%files
/usr/bin/monitor-toggle
/etc/dconf/db/local.d/10-keybindings-toggle-monitor

