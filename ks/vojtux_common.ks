%include fedora-live-base.ks
%include repos.ks

selinux --disabled

# add group because of brltty
group --name brlapi

# System services
services --enabled="chronyd,brltty,festival"

part / --size 10240 --fstype ext4

%packages
-nfs-utils
-NetworkManager-openvpn-gnome
@mate
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

# blacklist applications which breaks mate-desktop
-audacious

# office
@libreoffice

# dsl tools
rp-pppoe

# FIXME; apparently the glibc maintainers dislike this, but it got put into the
# desktop image at some point.  We won't touch this one for now.
nss-mdns

# Drop things for size
-@3d-printing
-fedora-icon-theme
-gnome-icon-theme
-gnome-icon-theme-symbolic
-gnome-software
-gnome-user-docs

-@mate-applications
-mate-icon-theme-faenza

# Help and art can be big, too
-gnome-user-docs
-evolution-help

#customizations for Agora
#removing inaccessible packages
-filezilla
-exaile

#additional software for Agora
pidgin
purple-facebook
purple-skypeweb
pidgin-skypeweb
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
vlc
sed
qt-at-spi
wget
jmtpfs
nano
speech-dispatcher-utils
soundconverter
tmux
unrar
timidity++
#festival
festival-freebsoft-utils
speech-dispatcher-festival
pulseaudio-utils
#display manager
-slick-greeter
-slick-greeter-mate
lightdm-gtk-greeter
lightdm-gtk-greeter-settings
#ocr
g++
python3-devel
tesseract-devel
lios

# settings and shortcuts
vojtux-settings

# a11y sound theme
a11y-sound-theme

# remote support
tmate
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


#installing ocrdesktop
#git clone https://github.com/chrys87/ocrdesktop.git /opt/ocrdesktop
#chmod -R 755 /opt/ocrdesktop
#ln -s /opt/ocrdesktop/ocrdesktop /usr/local/bin/ocrdesktop
# create script to toggle monitor
mkdir -p /usr/local/bin
cat > /usr/local/bin/monitor-toggle <<EOM
#!/bin/sh
output=$(xrandr | grep ' connected ' | awk '{print $1}' | head -1)
screenSize=$(xrandr | awk 'BEGIN {foundOutput=0}
    / '$output' / {foundOutput=1}
    /\*\+/ {print $1}
    /^[^ ]/ {if(foundOutput) exit 0}')
if [ "$screenSize" != "" ]; then
    xrandr --output $output --fb $screenSize --off
	spd-say 'monitor off'
else
    xrandr --output $output --auto
    spd-say 'Monitor on'
fi

EOM
chmod 755 /usr/local/bin/monitor-toggle

echo "Updating dconf databases..."
dconf update
# enabling accessibility
cat > /etc/profile.d/qtaccessibility.sh <<EOM
#enable general accessibility according to https://www.freedesktop.org/wiki/Accessibility/AT-SPI2/
export GTK_MODULES=gail:atk-bridge
export OOO_FORCE_DESKTOP=gnome
export GNOME_ACCESSIBILITY=1
# enables QT5 accessibility system-vide
export QT_ACCESSIBILITY=1
export QT_LINUX_ACCESSIBILITY_ALWAYS_ON=1
EOM

mkdir /etc/systemd/system/festival.service.d
cat > /etc/systemd/system/festival.service.d/override.conf <<EOM
[Service]
WorkingDirectory=/usr/share/festival/lib

EOM
#configure speech dispatcher
sed -i 's/#AddModule "espeak-ng"                "sd_espeak-ng" "espeak-ng.conf"/AddModule "espeak-ng"                "sd_espeak-ng" "espeak-ng.conf"/' /etc/speech-dispatcher/speechd.conf
sed -i 's/#AddModule "festival"                 "sd_festival"  "festival.conf"/AddModule "festival"                 "sd_festival"  "festival.conf"/' /etc/speech-dispatcher/speechd.conf
# prevent long delay when shutting down
echo "DefaultTimeoutStopSec=10s" >> /etc/systemd/system.conf
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
