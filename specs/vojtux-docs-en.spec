Name:           vojtux-docs-en
Version:        0.0.2
Release:        1%{?dist}
Summary:        documentation files for Vojtux distribution - English version
BuildArch:        noarch

License:        CC-BY-SA
URL:            https://github.com/vojtapolasek/vojtux
Source0:        https://github.com/vojtapolasek/vojtux/archive/master.tar.gz

BuildRequires:  pandoc


%description
This package contains documentation specific for Vojtux distribution in English language.

%prep
%autosetup -n vojtux-master


%build
pandoc -s --self-contained -t html -o docs/en/handout.html docs/en/handout.md


%install



%files
%doc docs/en/*

%changelog
* Fri Jan 24 2025 Vojtech Polasek <vpolasek@redhat.com>
- rebuild, Orca keyboard shortcuts are removed

* Tue Jun 07 2022 Vojtech Polasek <vpolasek@redhat.com>
- initial version
