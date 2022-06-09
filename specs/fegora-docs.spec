Name:           fegora-docs
Version:        0.0.1
Release:        2%{?dist}
Summary:        documentation files for Fegora distribution
BuildArch:        noarch

License:        CC-BY-SA
URL:            https://github.com/vojtapolasek/fegora
Source0:        https://github.com/vojtapolasek/fegora/archive/add_packaged_documentation.tar.gz

BuildRequires:  pandoc


%description
This package contains documentation specific for Fegora distribution. It contains Czech and English version of documentation.

%prep
%autosetup -n Fegora-add_packaged_documentation


%build
pandoc -s --self-contained -t html -o docs/en/handout.html docs/en/handout.md
pandoc -s --self-contained -t html -o docs/cs/handout.html docs/cs/handout.md


%install



%files
%doc docs/*

%changelog
* Thu Jun 09 2022 Vojtech Polasek <vpolasek@redhat.com> - 0.0.1-2
- change directory structure

* Tue Jun 07 2022 Vojtech Polasek <vpolasek@redhat.com>
- initial version
