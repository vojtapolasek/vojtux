Name:           fegora-docs
Version:        0.0.1
Release:        1%{?dist}
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
pandoc -s --self-contained -t html -o handout_en.html docs/handout_en.md
pandoc -s --self-contained -t html -o handout_cs.html docs/handout_cs.md


%install



%files
%doc handout_en.html
%doc handout_cs.html
%doc docs/keyboard_shortcuts.txt
%doc docs/klavesove_zkratky.txt



%changelog
* Tue Jun 07 2022 Vojtech Polasek <vpolasek@redhat.com>
- initial version
