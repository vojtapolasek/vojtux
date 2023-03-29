%include vojtux_common.ks

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
vojtux-docs-en
%end

%post
cat > /etc/dconf/db/local.d/03-keybindings <<- EOM

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

#apply Vojtux customizations
git clone https://github.com/vojtapolasek/Vojtux.git
cd vojtux/downloads
mkdir -p /etc/skel/.local/share/orca
cp -r orca/* /etc/skel/.local/share/orca/
mkdir -p /etc/skel/.config
cp mimeapps.list /etc/skel/.config/
cp .tmux.conf /etc/skel/
cd /opt/
rm -rf vojtux

# setup symlink to documentation
ln -s /usr/share/doc/vojtux-docs-en /etc/skel/documentation
ln -s /usr/share/doc/vojtux-docs-en /home/liveuser/documentation
%end
