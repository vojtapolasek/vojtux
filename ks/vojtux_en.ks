%include vojtux_common.ks

# System language
lang en_US.UTF-8
keyboard us

timezone US/Eastern

%packages
tesseract-langpack-eng
hunspell-en
vojtux-docs-en
%end

%post
#apply Vojtux customizations
git clone https://github.com/vojtapolasek/Vojtux.git
cd vojtux/downloads
mkdir -p /etc/skel/.config
cp mimeapps.list /etc/skel/.config/
cp .tmux.conf /etc/skel/
cd /opt/
rm -rf vojtux

# setup symlinks to documentation: in the home directory and also on
# the desktop, so that new users see the documentation right after login
ln -s /usr/share/doc/vojtux-docs-en /etc/skel/documentation
ln -s /usr/share/doc/vojtux-docs-en /home/liveuser/documentation
mkdir -p /etc/skel/Desktop /home/liveuser/Desktop
ln -s /usr/share/doc/vojtux-docs-en /etc/skel/Desktop/documentation
ln -s /usr/share/doc/vojtux-docs-en /home/liveuser/Desktop/documentation
%end
