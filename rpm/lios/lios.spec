Name:           lios
Version:        1
Release:        0
Summary:        Linux-Intelligent-Ocr-Solution
License:        GPL-3.0+

BuildRequires:  python3 python3-rpm-macros git
Requires:       espeak python3-gobject python3-enchant python3-speechd python3-sane PackageKit-gtk3-module aspell-en tesseract poppler-utils ImageMagick

%description
Lios package

%prep

%build
git clone https://github.com/zendalona/lios.git

%install
install -d %{buildroot}%{_prefix}
cd lios
python3 setup.py install --install-data=%{_prefix}

%files
%{_prefix}/share/lios
%{_prefix}/share/applications/Lios.desktop
%{_prefix}/share/applications/Lios-ocr-screenshot.desktop
%{_prefix}/share/man/man1/lios.1.gz
%{_prefix}/share/doc/lios/copyright
%{_prefix}/share/pixmaps/lios.xpm
%{_prefix}/share/locale/fr/LC_MESSAGES/lios.mo
%{_prefix}/share/locale/it/LC_MESSAGES/lios.mo
%{_bindir}/lios

%clean
rm -rf lios

%changelog
* Fri Jan 26 2024 Konstantin Kuminsky <k.k@redhat.com> - 1-0
- package from git repo

