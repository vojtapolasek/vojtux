#!/bin/bash

dnf -y install libvirt-daemon-kvm nano podman

systemctl start libvirtd.service

# Build the ISO through the same containerized path developers use: a
# privileged podman container whose base image is pinned by the RELEASE file,
# so the executor release does not need to match the target release.
build_dir=$(mktemp -d)
OUTPUT_DIR=$build_dir CONTAINER_TOOL=podman containerbuild/build.sh
vojtux_iso_path=$(find "$build_dir" -name "vojtux_$(tr -d '[:space:]' < RELEASE).iso" | head -1)
if [ -z "$vojtux_iso_path" ] || [ ! -s "$vojtux_iso_path" ]; then
  echo "containerbuild/build.sh did not produce a bootable ISO" >&2
  exit 1
fi
mv "$vojtux_iso_path" /var/lib/libvirt/images/vojtux.iso
rm -rf "$build_dir"

virsh net-define tests/vojtux_provision/vojtux_net.xml
virsh define tests/vojtux_provision/vojtux.xml
virsh net-start default
virsh start Vojtux
VOJTUX_IP_ADDR=$(virsh -q domifaddr Vojtux | sed -rn 's/.+ +([^ ]+)\/[0-9]+$/\1/p')
wait_tries=0
while [[ ! $VOJTUX_IP_ADDR ]]; do
  wait_tries=$((wait_tries + 1))
  if [ $wait_tries -ge 60 ]; then
    echo "Timed out (10 min) waiting for the Vojtux VM IP address" >&2
    exit 1
  fi
  sleep 10
  VOJTUX_IP_ADDR=$(virsh -q domifaddr Vojtux | sed -rn 's/.+ +([^ ]+)\/[0-9]+$/\1/p')
done
echo "The IP address of the Vojtux VM is $VOJTUX_IP_ADDR"
echo "$VOJTUX_IP_ADDR    vojtux" >> /etc/hosts
