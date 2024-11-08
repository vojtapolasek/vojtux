%global _lios_repo_url https://github.com/zendalona/lios
%global _lios_repo_commit b1fe5e29968a695edabc500d4c4f7e5eb05de01a

Name:           lios
Version:        2.5
Release:        20241108.1.gitb1fe5e29968a695e
Summary:        Linux-Intelligent-Ocr-Solution
License:        GPL-3.0+

BuildRequires:  git python%{python3_pkgversion}-devel
Requires:       python%{python3_pkgversion}-sane python%{python3_pkgversion}-speechd tesseract ImageMagick espeak poppler-utils python%{python3_pkgversion}-enchant aspell-en
Recommends: tesseract-osd

%generate_buildrequires
cd lios
%pyproject_buildrequires

%description
Easy-OCR solution for GNU/Linux

%prep
git clone %{_lios_repo_url}.git lios
cd lios
git checkout %{_lios_repo_commit}

%build
cd lios
%pyproject_wheel

%install
cd lios
%pyproject_install
%pyproject_save_files lios

%files -n lios -f %{pyproject_files}
%{_datadir}/lios
%{_datadir}/applications/Lios.desktop
%{_datadir}/applications/Lios-ocr-screenshot.desktop
%{_datadir}/pixmaps/lios.xpm
%{_datadir}/locale/fr/LC_MESSAGES/lios.mo
%{_datadir}/locale/it/LC_MESSAGES/lios.mo
%{_mandir}/man1/lios.1.gz
%{_docdir}/lios/copyright
%{_bindir}/lios

%changelog
* Fri Nov 08 2024 Vojtech Polasek <vpolasek@redhat.com> 2.5-20241108.1.git-b1fe5e29968a695e
- restructurue the release field so that it is simpler

* Thu Nov 07 2024 Vojtech Polasek <vpolasek@redhat.com> 2.5-20241107.1^b1fe5e29968a695e
- add tesseract-osd as a weak dependency

* Fri Nov 01 2024 Vojtech Polasek <vpolasek@redhat.com> 2.5-20241025^b1fe5e29968a695e
- initial package from Zendalona git repo

