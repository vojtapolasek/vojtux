Name:           fegora-docs-en
Version:        0.0.1
Release:        1%{?dist}
Summary:        documentation files for Fegora distribution - English version
BuildArch:        noarch

License:        CC-BY-SA
URL:            https://github.com/vojtapolasek/fegora
Source0:        https://github.com/vojtapolasek/fegora/archive/add_packaged_documentation.tar.gz

BuildRequires:  pandoc


%description
This package contains documentation specific for Fegora distribution in English language.

%prep
%autosetup -n Fegora-add_packaged_documentation


%build
pandoc -s --self-contained -t html -o docs/en/handout.html docs/en/handout.md


%install



%files
%doc docs/en/*

%changelog
* Tue Jun 07 2022 Vojtech Polasek <vpolasek@redhat.com>
- initial version
