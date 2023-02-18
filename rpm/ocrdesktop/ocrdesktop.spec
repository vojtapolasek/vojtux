Name:     ocrdesktop
Version:  4.0
Release:  2
Summary:  Accessibility tool that converts content of the current window into a text
License:  Public Domain

Requires: python3 tesseract tesseract-langpack-eng python3-pillow python3-pyatspi python-pytesseract libwnck3 gtk3

SOURCE0:  ocrdesktop
SOURCE1: 09-keybindings-ocrdesktop

%description
RPM package for ocrdesktop

%install
install -d %{buildroot}/opt/ocrdesktop
install -m 755 %{SOURCE0} %{buildroot}/opt/ocrdesktop/ocrdesktop
install -d %{buildroot}/etc/dconf/db/local.d
install %{SOURCE1} %{buildroot}/etc/dconf/db/local.d/09-keybindings-ocrdesktop

%files
%dir /opt/ocrdesktop
/opt/ocrdesktop/ocrdesktop
/etc/dconf/db/local.d/09-keybindings-ocrdesktop

%post
ln -s /opt/ocrdesktop/ocrdesktop /usr/local/bin/ocrdesktop

%postun
rm -f /usr/local/bin/ocrdesktop
