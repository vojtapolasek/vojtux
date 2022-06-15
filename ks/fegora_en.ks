%include fegora_common.ks

# System language
lang en_US.UTF-8
keyboard us

timezone US/Eastern

%packages
tesseract-langpack-eng
festvox-awb-arctic-hts
festvox-bdl-arctic-hts
festvox-clb-arctic-hts
festvox-jmk-arctic-hts
festvox-kal-diphone
festvox-rab-diphone
festvox-rms-arctic-hts
festvox-slt-arctic-hts
hunspell-en
fegora-docs-en
%end

%post
cat > /etc/dconf/db/local.d/03-keybindings <<- EOM
[org/mate/desktop/keybindings/custom0]
action='firefox'
binding='<Alt><Mod4>f'
name='Firefox'

[org/mate/desktop/keybindings/custom1]
action='mate-terminal'
binding='<Primary><Alt>t'
name='Launch terminal'

[org/mate/desktop/keybindings/custom2]
action='sh -c "amixer set Master 5%+ && play /usr/share/sounds/freedesktop/stereo/audio-volume-change.oga"'
binding='<Alt><Mod4>Up'
name='Volume up'

[org/mate/desktop/keybindings/custom3]
action='sh -c "amixer set Master 5%- && play /usr/share/sounds/freedesktop/stereo/audio-volume-change.oga"'
binding='<Alt><Mod4>Down'
name='Volume down'

[org/mate/desktop/keybindings/custom4]
action='sh -c "amixer set Master toggle && play /usr/share/sounds/freedesktop/stereo/audio-volume-change.oga"'
binding='<Alt><Mod4>Left'
name='Toggle mute'

[org/mate/desktop/keybindings/custom5]
action='caja .'
binding='<Mod4>Home' 
name='Home folder'

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
name='Toggle monitor'

EOM

dconf update

#apply Fegora customizations
git clone https://github.com/vojtapolasek/Fegora.git
cd Fegora/downloads
mkdir -p /etc/skel/.local/share/orca
cp -r orca/* /etc/skel/.local/share/orca/
mkdir -p /etc/skel/.config
cp mimeapps.list /etc/skel/.config/
cp .tmux.conf /etc/skel/
cd /opt/
rm -rf Fegora

# setup symlink to documentation
ln -s /usr/share/doc/fegora-docs-en /etc/skel/documentation
ln -s /usr/share/doc/fegora-docs-en /home/liveuser/documentation
%end
