# CI-only kickstart: the product kickstart plus everything the test flow
# (tests/vojtux_provision + tests/main.fmf) needs to reach the live system.
# Do not ship images built from this file: it enables password-less SSH.

%include vojtux_en.ks

%post
# The base live kickstart disables sshd (services --disabled=sshd), and a
# later `services` line does not override it, so enable the unit directly.
systemctl enable sshd

# sshd reads drop-ins from sshd_config.d (Include at the top of sshd_config).
mkdir -p /etc/ssh/sshd_config.d
cat > /etc/ssh/sshd_config.d/70-vojtux-ci.conf <<EOF
PasswordAuthentication yes
PermitEmptyPasswords yes
EOF

# The test flow runs as liveuser over SSH and needs root for runtest.sh.
echo 'liveuser ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/99liveuser-ci
chmod 440 /etc/sudoers.d/99liveuser-ci

# The dogtail runner needs a graphical session to attach to, so log liveuser
# straight into MATE. Drop in a lightdm.conf.d file rather than editing
# /etc/lightdm/lightdm.conf: lightdm reads the drop-ins last, so they win, and
# the product image (which has no autologin) is left as shipped.
# "mate" is the session name of /usr/share/xsessions/mate.desktop.
mkdir -p /etc/lightdm/lightdm.conf.d
cat > /etc/lightdm/lightdm.conf.d/60-vojtux-ci.conf <<EOF
[Seat:*]
autologin-user=liveuser
autologin-user-timeout=0
autologin-session=mate
EOF
%end
