# What is it about?

This repository contains resources concerning unofficial Linux distribution aimed at visually impaired users. This distribution is called Fegora, because it is based on Fedora and it was presented at Agora event. Agora is an event in Czech Republic, where workshops about information technology for visually impaired are presented.

Currently the repo and described workflow is aimed at creating USB drives with preinstalled Fegora. We chose this approach instead of live images because users can not only test the distribution, but also use the USB drive as normal medium for transfering data. Their configuration in Fegora is also persistently saved.

## Building installation ISO

The main technical idea is to build an ISO image which will perform automatic partitioning of the USB drive and installation of Fegora. Everything powered by Kickstart. So far it is based on Fedora Everything net install image located at <https://mirror.karneval.cz/pub/linux/fedora/linux/releases/32/Everything/x86_64/iso/>.

Kickstart documentation can be found at <https://pykickstart.readthedocs.io/en/latest/kickstart-docs.html>.

Clone this repository and modify the ks.cfg file as needed.

WARNING! Currently the kickstart contains default passwords for root user and regular user. We strongly recommend to change these passwords to something unique before creating the installation ISO image. Also see the last part of the kickstart. There are two partition schemes - one for 16 GiB disks, and another for 32 GiB disk. Comment / uncomment the appropriate one.

 Then run

sudo ./prepare_iso.sh

and the new file fegora.iso will be created in the same directory. The script will download the ISO and perform file verification. The script needs fuseiso and mkisofs utilities to be present.

## Installing from the ISO

Warning! The installation ISO will try to install to the first detected hard drive! Therefore using VM is highly recommended, I am not responsible for any loss of your data if you use real machine!

After reading the warning above, read it again and let's prepare the VM. Our aim is to make the process of booting of the resulting USB drive as easy as possible. Therefore we decided to support booting through UEFI as well as BIOS. The installation expects to be run in machine with EFI enabled. If you don't have such a VM, we can't guarantee the results. Following are rough instructions for Virtmanager.

Firstly download the OVMF files for your Linux distribution. The OVMF is an EFI firmware for the virtual machine. For example, on Fedora the package is called edk2-ovmf.

Then check your configuration file in /etc/libvirt/qemu.conf. The important variable is called nvram. It contains array of paths which should point to the needed files. There is usually some default commented value, make sure that the variable is uncommented and points to existing files. This may be different for every distro. For example the line looks like

```
nvram = ["/usr/share/OVMF/OVMF_CODE.fd:/usr/share/OVMF/OVMF_VARS.fd", "/usr/share/OVMF/OVMF_CODE.secboot.fd:/usr/share/OVMF/OVMF_VARS.fd"]
```

Create a new virtual machine. Select option for installation from the ISO image and select the modified ISO image as the installation source. Before starting actual installation check the box which allows you to do detailed modifications. Make sure that on the General tab the machine is configured to use UEFI, not BIOS. Attach the USB drive as a new USB host device. Make sure that no other drives or storage devices are attached to the VM.

Make sure that the virtual machine will boot from the ISO image. I recommend you to attach a serial console to the VM and find out how to connect to it. For example, the consoles for Virtmanager can be found in the /dev/pts/ directory.

To list the consoles:

```
ls -l /dev/pts
```

Some consoles will be owned by your user, some by the user "nobody" or "qemu", based on your distro. Try connecting to consoles NOT owned by your user.

Now launch the machine and connect to the serial console if needed. The installation should be fully automatic, you can monitor its progress. If you want to see logs of Anaconda or access the shell, you will have to do it through the virtual  machine. Switch to the second console for shell, third console for logs and fourth console for storage logs. Use C-B n to move to the next console, C-b p to the previous one. Refer to the Tmux documentation for further info about moving between consoles.

## What is actually done?

As mentioned, the aim of this project is to automatically create images which can be later transfered to USB drives and handed to actual users. The installation is based on Fedora Mate Spin. The image is composed of three partitions, one EFI partition taking 512 MiB, one root partition taking cca 16 GiB and one data partition taking rest of the provided disk. The data partition is formatted as FAT32. The purpose of FAT32 partition is to maximize usage of provided space on USB drive and exchange of data with non-Linux world.

Following additional changes are applied:

- Grub is configured so that it can boot on both BIOS and UEFI, even with Secure boot enabled

- added RPM Fusion free and nonfree package repositories

- added custom repository with Festival Czech voices and one specific for this distro so that we can push updates

- system locale is set to Czech, keyboard to Czech qwertz, Czech and Slovak language packs are downloaded

- the time zone is set to Europe/Prague

- Orca screenreader starts at login screen and also after login for current and also newly created users

- Orca configuration is slightly modified, see below

- QT accessibility is enabled

- accessibility of applications run with sudo is enabled

- Grub tune is added, although it does not work in every case

- LIOS OCR software is installed, so far not as a package

- A short help in Czech is placed into home directory (handout.html), list of keyboard shortcuts (klavesove_zkratky.txt)

- some keyboard shortcuts are added, see below

- default Firefox profile is used with custom home page and bookmarks

- Caja audio previews are disabled

- file associations are modified so that audio files open in VLC

- Festival is enabled with Czech voice, however, behaves strangely on physical hardware

- /etc/systemd/system.conf is modified to speed up shutdown

- Selinux policiy is set to permissive

- Slick greeter is replaced with Lightdm GTK greeter because of problems with Orca not starting after login

- Ocrdesktop software is instaled, not as a package

- Tmux is configured with special keyboard shortcuts inspired by the Byobu project

- extra packages are preinstalled

    - gimagereader QT version

    - pidgin with support for Facebook and Skype Web

    - Xsane

    - various firmware and software for broader hardware support including wireless cards, printers, scanners, graphic cards

    - Exfat support through Fuse

    - Audacity

    - Soundconverter

    - Tesseract OCR engine with English, Czech and Slovak data

    - Ifuse for support of Apple storage

    - jmtpfs for support of MTP

    - Git, Curl, Wget, Sed

    - VLC player

    - Java-atk-wrapper, Qt-at-spi

    - Tmux for better working with consoles

    - Chromium

- Following packages were removed:

    - Exaile

    - Hexchat

    - Filezilla

    - Gnote

- there is a special script which ensures that the sound is not muted and is at 50% of volume on login screen

- a script for turning off physical monitor is added, functionality not tested

- a sound theme is added, [source](https://github.com/coffeeking/Linux-a11y-sound-theme)


## Orca modifications

- added keyboard shortcuts for modifying speech speed (Orca+up/down)

- added keyboard shortcut for modifying of speech pitch (Orca+left/right)

- added keyboard shortcut for modifying speech volume (Orca+home/end)

- added keyboard shortcuts for copying parts of flat review to clipboard (Orca+c, Orca+shift+c)

- added shortcuts for reading of last seen notifications (Orca+n...)

- disabled showing end-of-line characters on the braille display

## Added shortcuts

- Alt-Super-o - restart orca

- Alt-Super-up/down - change system volume

- Alt-Super-left - mute/unmute system volume

- Alt-Super-f - Firefox

- Alt-Super-s toggle screenreader through Mate

- Alt-Super-l start the LIOS software

- Super-o recognize current window with Ocrdesktop using Czech language

- CTRL-Super-o recognize current window with Ocrdesktop using English language

- ALT-Super-m - vypnutí / zapnutí monitoru

