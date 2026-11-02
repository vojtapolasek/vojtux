#!/bin/bash
# Post-process a freshly built Vojtux ISO so it boots unattended in the CI
# libvirt VM:
#  1) dracut/systemd-258 defect: the generated initrd lacks the
#     /usr/lib/systemd/systemd-sysroot-fstab-check symlink (in systemd 258 it
#     is a symlink to the fstab generator that dracut does not follow), which
#     makes the live image stop in dracut emergency mode.
#  2) the generated grub.cfg defaults to the "Test this media" entry; with
#     livemedia-creator --no-virt no md5sums are implanted, so the check
#     always fails and the live session halts. Boot the live entry instead.
# The ISO is repacked in place with its boot image preserved.
set -euo pipefail

ISO=${1:?usage: fix_iso.sh <path-to-iso>}

command -v xorriso >/dev/null || { echo "xorriso is required" >&2; exit 1; }

work=$(mktemp -d)
trap 'rm -rf "$work"' EXIT

# --- initrd: add the missing systemd-sysroot-fstab-check symlink -----------
xorriso -osirrox on -indev "$ISO" -extract /images/pxeboot/initrd.img "$work/initrd.img"
mkdir "$work/initrd"
( cd "$work/initrd" && xz -dc "$work/initrd.img" | cpio -idm --quiet )
(
  cd "$work/initrd"
  if [ ! -e usr/lib/systemd/systemd-sysroot-fstab-check ]; then
    ln -s system-generators/systemd-fstab-generator usr/lib/systemd/systemd-sysroot-fstab-check
  fi
  find . | cpio -o -H newc --quiet | xz --check=crc32 -T0 > "$work/initrd_fixed.img"
)

# --- grub: boot the live entry directly with a short timeout ---------------
xorriso -osirrox on -indev "$ISO" -extract /boot/grub2/grub.cfg "$work/grub.cfg"
sed -i -E 's/^set default=.*/set default="0"/; s/^set timeout=[0-9]+/set timeout=1/' "$work/grub.cfg"

xorriso -indev "$ISO" \
  -map "$work/initrd_fixed.img" /images/pxeboot/initrd.img \
  -map "$work/grub.cfg" /boot/grub2/grub.cfg \
  -outdev "$ISO.fixed" -boot_image any replay -close on
mv "$ISO.fixed" "$ISO"
echo "Fixed ISO written to $ISO"
