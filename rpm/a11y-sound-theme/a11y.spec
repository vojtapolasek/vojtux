Name:     a11y-sound-theme
Version:  1
Release:  2
Summary:  Linux-A11y sound themes
License:  GPL-3.0

BuildRequires: git

%description
RPM package with Linux-A11y sound themes

%prep

%build
git clone https://github.com/coffeeking/linux-a11y-sound-theme.git

cat > 12-panel-a11y <<EOM
#sound theme
[org/mate/desktop/sound]
event-sounds=true
input-feedback-sounds=true
theme-name='linux-a11y'

EOM

%install
install -d %{buildroot}%{_datadir}/sounds/
cp -r linux-a11y-sound-theme/linux-a11y %{buildroot}%{_datadir}/sounds/
install -d %{buildroot}%{_sysconfdir}/dconf/db/local.d
install 12-panel-a11y %{buildroot}%{_sysconfdir}/dconf/db/local.d/12-panel-a11y

%files
%{_datadir}/sounds/linux-a11y
%{_sysconfdir}/dconf/db/local.d/12-panel-a11y

%clean
rm -rf linux-a11y-sound-theme
rm -rf 12-panel-a11y

%changelog
* Sat Jun 10 2023 Konstantin Kuminsky <k.k@redhat.com> - 1-2
- First linux-a11y-sounds-theme package
