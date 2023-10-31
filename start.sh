#!/bin/sh
set -eux

# dbus needs to be running
dbus-uuidgen > /var/lib/dbus/machine-id
mkdir -p /var/run/dbus
dbus-daemon --config-file=/usr/share/dbus-1/system.conf --print-address

ksflatten -c $input_kickstart_file -o $output_kickstart_file
sudo livemedia-creator --make-iso --no-virt --iso-only --anaconda-arg="--noselinux" --iso-name vojtux_38.iso --project vojtux --releasever 38 --ks $output_kickstart_file --tmp /live/tmp

sudo find /live/tmp -name vojtux_38.iso -exec mv -t /output {} +
