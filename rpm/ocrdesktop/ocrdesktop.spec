Name:     ocrdesktop
Version:  4.0
Release:  2
Summary:  Accessibility tool that converts content of the current window into a text
License:  GPL+

Requires: python3 tesseract tesseract-langpack-eng python3-pillow python3-pyatspi python-pytesseract libwnck3 gtk3

URL:      https://github.com/chrys87/ocrdesktop/releases
SOURCE0:  https://github.com/chrys87/ocrdesktop/archive/refs/tags/%{version}.tar.gz
SOURCE1:  09-keybindings-ocrdesktop

%description
RPM package for ocrdesktop

%global debug_package %{nil}

%prep
%setup -q

%build

%install
install -d %{buildroot}%{_bindir}
install -m 0755 ocrdesktop %{buildroot}%{_bindir}/ocrdesktop
install -d %{buildroot}%{_sysconfdir}/dconf/db/local.d
install %{SOURCE1} %{buildroot}%{_sysconfdir}/dconf/db/local.d/09-keybindings-ocrdesktop

%files
%{_bindir}/ocrdesktop
%{_sysconfdir}/dconf/db/local.d/09-keybindings-ocrdesktop

%changelog
* Mon Jun 12 2023 Konstantin Kuminsky <k.k@redhat.com> - 4.0-2
- First ocrdesktop package
