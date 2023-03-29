Name:     a11y-sound-theme
Version:  1
Release:  2
Summary:  Linux-A11y sound themes
License:  GPL-3.0

BuildRequires: git

%description
RPM package with Linux-A11y sound themes

%build
git clone https://github.com/coffeeking/linux-a11y-sound-theme.git

cat > 12-panel-a11y <<EOM
#sound theme
[org/mate/desktop/sound]
event-sounds=true
input-feedback-sounds=true
theme-name='linux-a11y'

EOM

cat > 12-accessibility-a11y <<EOM
# Be nice to the users and pre-enable screen reading if they decide to install Gnome.
[org/gnome/desktop/a11y/applications]
screen-reader-enabled=true

EOM

%install
install -d %{buildroot}/usr/share/sounds/
cp -r linux-a11y-sound-theme/linux-a11y %{buildroot}/usr/share/sounds/
install -d %{buildroot}/etc/dconf/db/local.d
cp 12-panel-a11y %{buildroot}/etc/dconf/db/local.d/12-panel-a11y
cp 12-accessibility-a11y %{buildroot}/etc/dconf/db/local.d/12-accessibility-a11y

%files
/usr/share/sounds/linux-a11y
/etc/dconf/db/local.d/12-panel-a11y
/etc/dconf/db/local.d/12-accessibility-a11y

%clean
rm -rf linux-a11y-sound-theme
rm -rf 12-accessibility-a11y
rm -rf 12-panel-a11y
