#!/bin/bash

dnf -y install libvirt-daemon-kvm nano pykickstart lorax-lmc-novirt
systemctl start libvirtd.service
ksflatten -c ks/vojtux_en.ks -o vojtux.ks
cat >> vojtux.ks << EOM
services --enabled "sshd"

%post
echo "PermitEmptyPasswords yes" >> /etc/ssh/sshd_config
%end
EOM
livemedia-creator --make-iso --no-virt --iso-only  --anaconda-arg="--noselinux" --ks vojtux.ks --tmp tmp/ --iso-name vojtux.iso --project vojtux --timeout 30
vojtux_iso_path=$(find . -name vojtux.iso)
mv $vojtux_iso_path /var/lib/libvirt/images/vojtux.iso
virsh net-define tests/vojtux_provision/vojtux_net.xml
virsh define tests/vojtux_provision/vojtux.xml
virsh net-start default
virsh start Vojtux
VOJTUX_IP_ADDR=$(virsh -q domifaddr Vojtux | sed -rn 's/.+ +([^ ]+)\/[0-9]+$/\1/p')
while [[ ! $VOJTUX_IP_ADDR ]]; do
  sleep 10
  VOJTUX_IP_ADDR=$(virsh -q domifaddr Vojtux | sed -rn 's/.+ +([^ ]+)\/[0-9]+$/\1/p')
done
echo "The IP address of the Vojtux VM is $VOJTUX_IP_ADDR"
echo "$VOJTUX_IP_ADDR    vojtux" >> /etc/hosts
