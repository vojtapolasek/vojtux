Name:     ocrdesktop
Version:  4.0
Release:  2
Summary:  Accessibility tool that converts content of the current window into a text
License:  GPL+

Requires: python3 tesseract tesseract-langpack-eng python3-pillow python3-pyatspi python-pytesseract libwnck3 gtk3

URL:      https://github.com/chrys87/ocrdesktop/
SOURCE0:  https://github.com/chrys87/ocrdesktop/archive/refs/tags/4.0.tar.gz
SOURCE1:  09-keybindings-ocrdesktop

%description
RPM package for ocrdesktop

%prep
%setup -q

%install
install -d %{buildroot}%{_bindir}
install -m 0755 ocrdesktop %{buildroot}%{_bindir}/ocrdesktop
chmod 755 %{buildroot}/usr/bin/ocrdesktop
install -d %{buildroot}%{_sysconfdir}/dconf/db/local.d
install %{SOURCE1} %{buildroot}%{_sysconfdir}/dconf/db/local.d/09-keybindings-ocrdesktop

%files
%{_bindir}/ocrdesktop
%{_sysconfdir}/dconf/db/local.d/09-keybindings-ocrdesktop

%clean
rm -rf ../4.0.tar.gz
