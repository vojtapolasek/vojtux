%include vojtux_common.ks


# System language
lang cs_CZ.UTF-8
keyboard --xlayouts='cz'

# System timezone
timezone Europe/Prague --isUtc



%packages
tesseract-langpack-ces
tesseract-langpack-slk
hunspell-cs
vojtux-docs-cs
%end

%post

# set x11 keymap manually, for some reason the keyboard kickstart command does not work
#localectl set-x11-keymap cz




cat > /etc/dconf/db/local.d/03-keybindings <<- EOM
[org/mate/desktop/keybindings/custom0]
action='firefox'
binding='<Alt><Mod4>f'
name='Firefox'

[org/mate/desktop/keybindings/custom1]
action='mate-terminal'
binding='<Primary><Alt>t'
name='Terminál'

[org/mate/desktop/keybindings/custom2]
action='sh -c "amixer set Master 5%+ && play /usr/share/sounds/freedesktop/stereo/audio-volume-change.oga"'
binding='<Alt><Mod4>Up'
name='Zvýšit hlasitost'

[org/mate/desktop/keybindings/custom3]
action='sh -c "amixer set Master 5%- && play /usr/share/sounds/freedesktop/stereo/audio-volume-change.oga"'
binding='<Alt><Mod4>Down'
name='Snížit hlasitost'

[org/mate/desktop/keybindings/custom4]
action='sh -c "amixer set Master toggle && play /usr/share/sounds/freedesktop/stereo/audio-volume-change.oga"'
binding='<Alt><Mod4>Left'
name='Přepnout ztlumení'

[org/mate/desktop/keybindings/custom5]
action='caja .'
binding='<Mod4>Home' 
name='Domovský adresář'

[org/mate/desktop/keybindings/custom6]
action='orca -r'
binding='<Alt><Mod4>o'
name='Restart Orca'

[org/mate/desktop/keybindings/custom7]
action='lios'
binding='<Alt><Mod4>l'
name='Linux Intelligent OCR Software'

#[org/mate/desktop/keybindings/custom8]
#action='/opt/ocrdesktop/ocrdesktop -l ces'
#binding='<Mod4>o'
#name='OCR aktuálního okna (český jazyk)'

#[org/mate/desktop/keybindings/custom9]
#action='/opt/ocrdesktop/ocrdesktop -l eng'
#binding='<Primary><Mod4>o'
#name='OCR aktuálního okna (anglický jazyk)'

[org/mate/desktop/keybindings/custom10]
action='/usr/local/bin/monitor-toggle'
binding='<Alt><Mod4>m'
name='zapnutí / vypnutí monitoru'

# configure Czech keyboard
[org/mate/desktop/peripherals/keyboard/kbd]
layouts=['cz']
options=['grp\tgrp:win_space_toggle', 'grp\tgrp:alts_toggle']

EOM
echo "Updating dconf databases..."
dconf update

#apply Vojtux customizations
git clone https://github.com/vojtapolasek/vojtux.git
cd vojtux/downloads
mkdir -p /etc/skel/.local/share/orca
cp -r orca/* /etc/skel/.local/share/orca/
mkdir -p /etc/skel/.config
cp mimeapps.list /etc/skel/.config/
cp .tmux.conf /etc/skel/
cd /opt/
rm -rf vojtux

# setup symlink to documentation
ln -s /usr/share/doc/vojtux-docs-cs /etc/skel/dokumentace
ln -s /usr/share/doc/vojtux-docs-cs /home/liveuser/dokumentace

%end
