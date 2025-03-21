%include fedora-live-base.ks
%include repos.ks

selinux --disabled

# add group because of brltty
group --name brlapi

# System services
services --enabled="chronyd,brltty"

part / --size 10240 --fstype ext4

%packages
@mate
@desktop-accessibility
compiz
compiz-plugins-main
compiz-plugins-extra
compiz-manager
compizconfig-python
compiz-plugins-experimental
libcompizconfig
compiz-plugins-main
ccsm
simple-ccsm
emerald-themes
emerald
fusion-icon
@networkmanager-submodules

# some apps from mate-applications
caja-actions
mate-disk-usage-analyzer

# office
@libreoffice

# dsl tools
rp-pppoe

# Drop things for size
-@3d-printing
-fedora-icon-theme
-gnome-icon-theme
-gnome-icon-theme-symbolic
-gnome-software
-gnome-user-docs

-mate-icon-theme-faenza

# Help and art can be big, too
-gnome-user-docs
-evolution-help

#customizations for Vojtux

#additional software for Vojtux
pidgin
purple-facebook
xsane
chromium
mate-menu
#hardware support
@hardware-support
gutenprint-cups
cups-filters
foomatic-db
foomatic-db-ppds
splix
hplip
xorg-x11-drv-nouveau
libsane-hpaio
xorg-x11-server-Xvfb
xorg-x11-drv-dummy
#more software
exfat-utils
audacity
soundconverter
ifuse
git
curl
@vlc
sed
wget
jmtpfs
nano
speech-dispatcher-utils
soundconverter
tmux
unrar
timidity++
#display manager
-slick-greeter
-slick-greeter-mate
lightdm-gtk-greeter
lightdm-gtk-greeter-settings
#ocr
lios
toggle-monitor

# settings and shortcuts
vojtux-settings
sox
# OCR desktop
ocrdesktop
ocrmypdf

# a11y sound theme
a11y-sound-theme

# remote support
tmate

# pandoc for document conversion and also used during testing
pandoc

# brltty-xw for testing braille output without a physical device
brltty-xw
%end

%post
# configure temporary dns
cat >> /etc/resolv.conf << EOM
nameserver 8.8.8.8
nameserver 8.8.4.4
EOM

cat >> /etc/rc.d/init.d/livesys << EOF


# make the installer show up
if [ -f /usr/share/applications/liveinst.desktop ]; then
  # Show harddisk install in shell dash
  sed -i -e 's/NoDisplay=true/NoDisplay=false/' /usr/share/applications/liveinst.desktop ""
fi
mkdir /home/liveuser/Desktop
usermod -a -G brlapi liveuser
cp /usr/share/applications/liveinst.desktop /home/liveuser/Desktop

# and mark it as executable
chmod +x /home/liveuser/Desktop/liveinst.desktop

# rebuild schema cache with any overrides we installed
glib-compile-schemas /usr/share/glib-2.0/schemas

# set up lightdm autologin
sed -i 's/^#autologin-user=.*/autologin-user=liveuser/' /etc/lightdm/lightdm.conf
sed -i 's/^#autologin-user-timeout=.*/autologin-user-timeout=0/' /etc/lightdm/lightdm.conf
#sed -i 's/^#show-language-selector=.*/show-language-selector=true/' /etc/lightdm/lightdm-gtk-greeter.conf

# set MATE as default session, otherwise login will fail
sed -i 's/^#user-session=.*/user-session=mate/' /etc/lightdm/lightdm.conf

# Turn off PackageKit-command-not-found while uninstalled
if [ -f /etc/PackageKit/CommandNotFound.conf ]; then
  sed -i -e 's/^SoftwareSourceSearch=true/SoftwareSourceSearch=false/' /etc/PackageKit/CommandNotFound.conf
fi

# no updater applet in live environment
rm -f /etc/xdg/autostart/org.mageia.dnfdragora-updater.desktop

# make sure to set the right permissions and selinux contexts
chown -R liveuser:liveuser /home/liveuser/
restorecon -R /home/liveuser/


EOF

#rpm fusion keys
echo "== RPM Fusion Free: Base section =="
echo "Importing RPM Fusion keys"
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-rpmfusion-free-fedora-*-primary
echo "Importing RPM Fusion keys"
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-rpmfusion-nonfree-fedora-*-primary

# import Vojtux-apps key
dnf copr enable -y tyrylu/vojtux-apps

echo "Updating dconf databases..."
dconf update

#configure speech dispatcher
sed -i 's/#AddModule "espeak-ng"                "sd_espeak-ng" "espeak-ng.conf"/AddModule "espeak-ng"                "sd_espeak-ng" "espeak-ng.conf"/' /etc/speech-dispatcher/speechd.conf

#setup lightdm
# create a wrapper script which makes sure that sound is unmuted and at 50% on login screen
cat > /usr/local/bin/orca-login-wrapper <<EOM
#!/bin/bash

amixer -c 0 set Master playback 50% unmute
/usr/bin/orca &

EOM
chmod 755 /usr/local/bin/orca-login-wrapper
cat >> /etc/lightdm/lightdm-gtk-greeter.conf <<EOM
[greeter]
background = /usr/share/backgrounds/default.png
reader = /usr/local/bin/orca-login-wrapper
a11y-states = +reader

EOM

# disable temporary dns
echo "" > /etc/resolv.conf

%end
