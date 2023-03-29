Name:     vojtux-settings
Version:  1
Release:  1
Summary:  Settings for Vojtux
License:  Public Domain

%description
RPM package with settings for Vojtux

%build
cat > 01-accessibility <<EOM
[org/mate/desktop/applications/at/visual]
exec='orca'

[org/mate/desktop/interface]
accessibility=true

#enabling sound theme
[org/mate/desktop/sound]
theme-name='freedesktop'
event-sounds=true

EOM

cat > 02-panel <<EOM
[org/mate/panel/general]
object-id-list=['menu-bar', 'terminal', 'web-browser', 'email-client', 'volume-control', 'notification-area', 'show-desktop', 'window-list', 'object-0']
toplevel-id-list=['top']

[org/mate/panel/objects/clock]
applet-iid='ClockAppletFactory::ClockApplet'
locked=true
object-type='applet'
panel-right-stick=true
position=0
toplevel-id='top'

[org/mate/panel/objects/email-client]
launcher-location='/usr/share/applications/mozilla-thunderbird.desktop'
locked=true
object-type='launcher'
position=40
toplevel-id='top'

[org/mate/panel/objects/file-browser]
launcher-location='/usr/share/applications/caja-browser.desktop'
locked=true
object-type='launcher'
position=10
toplevel-id='top'

[org/mate/panel/objects/menu-bar]
locked=true
object-type='menu-bar'
position=0
toplevel-id='top'

[org/mate/panel/objects/notification-area]
applet-iid='NotificationAreaAppletFactory::NotificationArea'
locked=true
object-type='applet'
panel-right-stick=true
position=10
toplevel-id='top'

[org/mate/panel/objects/terminal]
launcher-location='/usr/share/applications/mate-terminal.desktop'
locked=true
object-type='launcher'
position=20
toplevel-id='top'

[org/mate/panel/objects/web-browser]
launcher-location='/usr/share/applications/firefox.desktop'
locked=true
object-type='launcher'
position=30
toplevel-id='top'

# advanced mate menu
[org/mate/panel/objects/object-0]
applet-iid='MateMenuAppletFactory::MateMenuApplet'
object-type='applet'
panel-right-stick=false
position=-1
toplevel-id='top'


[org/gnome/desktop/wm/keybindings]
begin-move=@as []
begin-resize=@as []
close=['<Alt>F4']
lower=@as []
maximize=@as []
maximize-horizontally=@as []
maximize-vertically=@as []
move-to-monitor-left=['<Super>Left']
move-to-monitor-right=['<Super>Right']
move-to-workspace-1=['<Shift><Alt>F1']
move-to-workspace-2=['<Shift><Alt>F2']
move-to-workspace-3=['<Shift><Alt>F3']
move-to-workspace-4=['<Shift><Alt>F4']
move-to-workspace-down=['<Primary><Super>Down', '<Control><Shift><Alt>Down']
move-to-workspace-left=['<Primary><Super>Left']
move-to-workspace-right=['<Primary><Super>Right']
move-to-workspace-up=['<Primary><Super>Up', '<Control><Shift><Alt>Up']
raise=@as []
raise-or-lower=@as []
show-desktop=['<Super>d']
switch-applications=['', '<Alt>Tab']
switch-group=['<Super>Tab', '<Alt>Above_Tab']
switch-to-workspace-down=['<Primary><Alt>Down', '<Control><Alt>Down']
switch-to-workspace-left=['<Primary><Alt>Left']
switch-to-workspace-right=['<Primary><Alt>Right']
switch-to-workspace-up=['<Primary><Alt>Up', '<Control><Alt>Up']
switch-windows=['<Alt>Tab']
toggle-maximized=@as []
toggle-on-all-workspaces=@as []
toggle-shaded=@as []
unmaximize=@as []

#preventing sound previews in Caja
[org/mate/caja/preferences]
preview-sound='never'

#shortcut for stopping and starting screenreader
[org/mate/settings-daemon/plugins/media-keys]
screenreader='<Alt><Mod4>s'

EOM

cat > 03-keybindings <<EOM
[org/mate/desktop/keybindings/custom0]
action='firefox'
binding='<Alt><Mod4>f'
name='Firefox'

[org/mate/desktop/keybindings/custom1]
action='mate-terminal'
binding='<Primary><Alt>t'
name='Launch terminal'

[org/mate/desktop/keybindings/custom2]
action='sh -c "amixer set Master 5%%+ && play /usr/share/sounds/freedesktop/stereo/audio-volume-change.oga"'
binding='<Alt><Mod4>Up'
name='Volume up'

[org/mate/desktop/keybindings/custom3]
action='sh -c "amixer set Master 5%%- && play /usr/share/sounds/freedesktop/stereo/audio-volume-change.oga"'
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

EOM

%install
install -d %{buildroot}/etc/dconf/db/local.d
cp 01-accessibility %{buildroot}/etc/dconf/db/local.d/01-accessibility
cp 02-panel %{buildroot}/etc/dconf/db/local.d/02-panel
cp 03-keybindings %{buildroot}/etc/dconf/db/local.d/03-keybindings

%files
/etc/dconf/db/local.d/01-accessibility
/etc/dconf/db/local.d/02-panel
/etc/dconf/db/local.d/03-keybindings

%clean
rm -rf 01-accessibility
rm -rf 02-panel
rm -rf 03-keybindings

