%global _lios_repo_url https://github.com/zendalona/lios
%global _lios_repo_commit b1fe5e29968a695edabc500d4c4f7e5eb05de01a

Name:           lios
Version:        2.5
Release:        20241220.1.gitb1fe5e29968a695e%{?dist}
Summary:        Linux-Intelligent-Ocr-Solution
License:        GPL-3.0+
SOURCE0:        10-keybindings-lios
BuildArch:	noarch

BuildRequires:  git python%{python3_pkgversion}-devel
Requires:       python%{python3_pkgversion}-sane python%{python3_pkgversion}-speechd tesseract ImageMagick espeak poppler-utils python%{python3_pkgversion}-enchant aspell-en dconf
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
install -d %{buildroot}%{_sysconfdir}/dconf/db/distro.d
install %{SOURCE0} %{buildroot}%{_sysconfdir}/dconf/db/distro.d/10-keybindings-lios

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
%{_sysconfdir}/dconf/db/distro.d/10-keybindings-lios

%post
dconf update

%postun
dconf update

%changelog
* Fri Dec 20 2024 Vojtech Polasek <vpolasek@redhat.com> 20241220.1.gitb1fe5e29968a695e
- change entry name for the shortcut to be aligned with other shortcuts provided by vojtux

* Fri Dec 06 2024 Vojtech Polasek <vpolasek@redhat.com> 20241206.1.gitb1fe5e29968a695e
- aligning spec file with standards

* Fri Nov 15 2024 Vojtech Polasek <vpolasek@redhat.com> 2.5-20241115.1.git-b1fe5e29968a695e
- package the keyboard shortcut


* Fri Nov 08 2024 Vojtech Polasek <vpolasek@redhat.com> 2.5-20241108.1.git-b1fe5e29968a695e
- restructurue the release field so that it is simpler

* Thu Nov 07 2024 Vojtech Polasek <vpolasek@redhat.com> 2.5-20241107.1^b1fe5e29968a695e
- add tesseract-osd as a weak dependency

* Fri Nov 01 2024 Vojtech Polasek <vpolasek@redhat.com> 2.5-20241025^b1fe5e29968a695e
- initial package from Zendalona git repo

