#!/bin/bash	

mountdir=$(mktemp -d)
fedoradir=$(mktemp -d)

if [ ! -e 'Fedora-Everything-netinst-x86_64-30-1.2.iso' ]
then echo "downloading ISO and checksums..."
wget 'https://mirror.karneval.cz/pub/linux/fedora/linux/releases/30/Everything/x86_64/iso/Fedora-Everything-netinst-x86_64-30-1.2.iso'
wget 'https://mirror.karneval.cz/pub/linux/fedora/linux/releases/30/Everything/x86_64/iso/Fedora-Everything-30-1.2-x86_64-CHECKSUM'
sha256sum -c 'Fedora-Everything-30-1.2-x86_64-CHECKSUM'
fi
echo "mounting ISO..."
fuseiso 'Fedora-Everything-netinst-x86_64-30-1.2.iso' $mountdir
echo "copying ISO contents..."
cp -a $mountdir/* $fedoradir
echo "unmounting ISO..."
fusermount -u $mountdir
rmdir $mountdir
echo "copying kickstart file into $fedoradir"
cp ks.cfg $fedoradir
echo "modifying isolinux.cfg..."
sed -i '/menu default/d' $fedoradir/isolinux/isolinux.cfg
sed -i '/label linux/i label kickstart\n  menu label \^Install accessible Fedora 30 Mate\n  menu default\n  kernel vmlinuz\n  append initrd=initrd\.img inst\.ks=hd:LABEL=fedora console=ttyS0,9600\n' $fedoradir/isolinux/isolinux.cfg
echo "modifying EFI grub.cfg..."
sed -i "s/^set default=\"1\"$/set default=\"0\"/" $fedoradir/EFI/BOOT/grub.cfg
sed -i "/\#\#\# BEGIN \/etc\/grub\.d\/10\_linux \#\#\#/a menuentry \'Install accessible Fedora 30\' --class fedora --class gnu-linux --class gnu --class os \{\n\tlinuxefi \/images\/pxeboot\/vmlinuz inst\.ks=hd:LABEL=fedora console=ttyS0,9600\n\tinitrdefi \/images\/pxeboot\/initrd\.img\n\}\n" $fedoradir/EFI/BOOT/grub.cfg
echo "repacking iso..."
mkisofs -o fegora.iso -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -J -R -V fedora -eltorito-alt-boot -b images/efiboot.img -no-emul-boot $fedoradir
echo "cleaning up..."
rm -rf $fedoradir
