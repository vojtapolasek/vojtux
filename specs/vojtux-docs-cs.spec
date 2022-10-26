Name:           vojtux-docs-cs
Version:        0.0.1
Release:        1%{?dist}
Summary:        documentation files for Vojtux distribution - Czech version
BuildArch:        noarch

License:        CC-BY-SA
URL:            https://github.com/vojtapolasek/vojtux
Source0:        https://github.com/vojtapolasek/vojtux/archive/master.tar.gz

BuildRequires:  pandoc


%description
This package contains documentation specific for Vojtux distribution in Czech language.

%prep
%autosetup -n vojtux-master


%build
pandoc -s --self-contained -t html -o docs/cs/handout.html docs/cs/handout.md


%install



%files
%doc docs/cs/*

%changelog
* Tue Jun 07 2022 Vojtech Polasek <vpolasek@redhat.com>
- initial version
