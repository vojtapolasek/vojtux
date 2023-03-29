Name:     ocrdesktop
Version:  4.0
Release:  2
Summary:  Accessibility tool that converts content of the current window into a text
License:  Public Domain

Requires: python3 tesseract tesseract-langpack-eng python3-pillow python3-pyatspi python-pytesseract libwnck3 gtk3

URL:      https://github.com/chrys87/ocrdesktop/
%undefine _disable_source_fetch
SOURCE0:  https://github.com/chrys87/ocrdesktop/archive/refs/tags/4.0.tar.gz
SOURCE1:  09-keybindings-ocrdesktop

%description
RPM package for ocrdesktop

%prep
%setup -q

%install
install -d %{buildroot}/usr/bin
cp ocrdesktop %{buildroot}/usr/bin/ocrdesktop
chmod 755 %{buildroot}/usr/bin/ocrdesktop
install -d %{buildroot}/etc/dconf/db/local.d
install %{SOURCE1} %{buildroot}/etc/dconf/db/local.d/09-keybindings-ocrdesktop

%files
/usr/bin/ocrdesktop
/etc/dconf/db/local.d/09-keybindings-ocrdesktop

%clean
rm -rf ../4.0.tar.gz
