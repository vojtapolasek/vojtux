Name:           lios
Version:        1
Release:        0
Summary:        Linux-Intelligent-Ocr-Solution
License:        GPL-3.0+

BuildRequires:  git python3
Requires:       python3-imaging-sane python3-speechd tesseract-ocr imagemagick cuneiform espeak poppler-utils python3-enchant aspell-en gir1.2-gst-plugins-base-1.0 gir1.2-gstreamer-1.0

%description
Lios package

%prep

%build
git clone https://github.com/zendalona/lios.git

%install
cd lios
python3 setup.py install --install-data=%{_prefix} --root=%{buildroot}

%files
/usr/lib/python*/site-packages/
%{_datadir}/lios
%{_datadir}/applications/Lios.desktop
%{_datadir}/applications/Lios-ocr-screenshot.desktop
%{_datadir}/pixmaps/lios.xpm
%{_datadir}/locale/fr/LC_MESSAGES/lios.mo
%{_datadir}/locale/it/LC_MESSAGES/lios.mo
%{_mandir}/man1/lios.1.gz
%{_docdir}/lios/copyright
%{_bindir}/lios

%clean
rm -rf lios

%changelog
* Fri Jan 26 2024 Konstantin Kuminsky <k.k@redhat.com> - 1-0
- package from git repo

