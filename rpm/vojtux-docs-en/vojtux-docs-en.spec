Name:           vojtux-docs-en
Version:        0.0.2
Release:        2%{?dist}
Summary:        documentation files for Vojtux distribution - English version
BuildArch:        noarch

License:        CC-BY-SA
URL:            https://github.com/vojtapolasek/vojtux
Source0: handout.md
Source1: keyboard_shortcuts.txt

BuildRequires:  pandoc


%description
This package contains documentation specific for Vojtux distribution in English language.

%prep

%build
pandoc -s --embed-resources --standalone -t html -o handout.html %{SOURCE0}


%install
install -d %{buildroot}%{_datadir}/doc/vojtux-docs-en
install %{SOURCE0} %{buildroot}%{_datadir}/doc/vojtux-docs-en/handout.md
install handout.html %{buildroot}%{_datadir}/doc/vojtux-docs-en/handout.html 
install %{SOURCE1} %{buildroot}%{_datadir}/doc/vojtux-docs-en/keyboard_shortcuts.txt

%files
%doc %{_datadir}/doc/vojtux-docs-en

%changelog
* Tue Mar 04 2025 Vojtech Polasek <vpolasek@redhat.com>
- change how the package is built (no longer download documentation from Github through https)

* Fri Jan 24 2025 Vojtech Polasek <vpolasek@redhat.com>
- rebuild, Orca keyboard shortcuts are removed

* Tue Jun 07 2022 Vojtech Polasek <vpolasek@redhat.com>
- initial version
