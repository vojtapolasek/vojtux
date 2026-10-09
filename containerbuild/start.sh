#!/bin/sh
set -eux

: "${RELEASEVER:?RELEASEVER must be set by containerbuild/build.sh}"

# dbus needs to be running
dbus-uuidgen > /var/lib/dbus/machine-id
mkdir -p /var/run/dbus
dbus-daemon --config-file=/usr/share/dbus-1/system.conf --print-address

ksflatten -c $input_kickstart_file -o $output_kickstart_file
livemedia-creator --make-iso --no-virt --iso-only --anaconda-arg="--noselinux" --iso-name vojtux_${RELEASEVER}.iso --project vojtux --releasever ${RELEASEVER} --ks $output_kickstart_file --tmp /live/tmp

find /live/tmp -name vojtux_${RELEASEVER}.iso -exec mv -t /output {} +
