#!/bin/bash	

mountdir=$(mktemp -d)
fedoradir=$(mktemp -d)

if [ ! -e 'Fedora-Everything-netinst-x86_64-29-1.2.iso' ]
then echo "downloading ISO and checksums..."
wget 'https://mirror.karneval.cz/pub/linux/fedora/linux/releases/29/Everything/x86_64/iso/Fedora-Everything-netinst-x86_64-29-1.2.iso'
wget 'https://mirror.karneval.cz/pub/linux/fedora/linux/releases/29/Everything/x86_64/iso/Fedora-Everything-29-1.2-x86_64-CHECKSUM'
sha256sum -c 'Fedora-Everything-29-1.2-x86_64-CHECKSUM'
fi
echo "mounting ISO..."
fuseiso 'Fedora-Everything-netinst-x86_64-29-1.2.iso' $mountdir
echo "copying ISO contents..."
cp -a $mountdir/* $fedoradir
echo "unmounting ISO..."
fusermount -u $mountdir
rmdir $mountdir
echo "copying kickstart file..."
cp ks.cfg $fedoradir
echo "modifying isolinux.cfg..."
sed -i '/menu default/d' $fedoradir/isolinux/isolinux.cfg
sed -i '/label linux/i label kickstart\n  menu label \^Install accessible Fedora 29 Mate\n  menu default\n  kernel vmlinuz\n  append initrd=initrd\.img inst\.ks=hd:LABEL=fedora console=ttyS0,9600\n' $fedoradir/isolinux/isolinux.cfg
echo "repacking iso..."
mkisofs -o fegora.iso -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -J -R -V fedora $fedoradir
echo "cleaning up..."
rm -r $fedoradir
