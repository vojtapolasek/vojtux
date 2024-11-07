Name:           mate-shortcut-test
Version:        1
Release:        0
Summary:        test package
License:        GPL-3.0+
SOURCE0:    50-test.gschema.override

%description
A package to test gconf overrides


%install
install -D -m 0644 %SOURCE0 %{buildroot}%{_datadir}/glib-2.0/schemas/50-test.gschema.override

%files

%{_datadir}/glib-2.0/schemas/50-test.gschema.override
