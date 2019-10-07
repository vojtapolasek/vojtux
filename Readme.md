# What is it about?

This repository contains resources related to presentation of modified version of Fedora 29 on the Agora Spring event 2019 in Brno. During this events there will be two runs of two workshops focused on introducing Linux and its accessibility features to blind and visually impaired people.

During both workshops it is planed to give a USB drive to participants. This drive will contain working installation of Fedora 29 with various accessibility tweaks to suit the target audience.

## Building installation ISO

The main technical idea is to build an ISO image which will perform automatic partitioning of the USB drive and installation of Fedora. Everything powered by Kickstart. So far it is based on Fedora Everything net install image located at <https://mirror.karneval.cz/pub/linux/fedora/linux/releases/30/Everything/x86_64/iso/>.

Kickstart documentation can be found at <https://pykickstart.readthedocs.io/en/latest/kickstart-docs.html>.

Clone this repository and modify the ks.cfg file as needed.

Warning! You need to configure the root password and the user password before you can proceed with the installation. The password is not provided in the default kickstart file for security reasons, make up your own! Modify two first lines of the kickstart file, an example follows configuring the "root" as the root password and "user" as the default user password:

rootpw root

user --groups=wheel --name=agora --password=user --plaintext --gecos="Agora participant"

 Then run

sudo ./prepare_iso.sh

and the new file fegora.iso will be created in the same directory. The script will download the ISO and perform file verification. The script needs fuseiso and mkisofs utilities to be present.

## Installing from the ISO

Warning! The installation ISO will try to install to the first detected hard drive! Therefore using VM is highly recommended, I am not responsible for any loss of your data if you use real machine!

After reading the warning above, read it again and get ready some VM Connect the USB drive which you want to use as a destination for installation and also mount the ISO created in the previous step. Make sure that the virtual machine will boot from the ISO image. I recommend you to attach a serial console to the VM and find out how to connect to it. For example, the consoles for Virtmanager can be found in the /dev/pts/ directory.

Our aim is to make the booting as easy as possible. Therefore we decided to use EFI for booting if possible. The installation expects to be run in machine with EFI enabled. If you don't have such a VM, we can't guarantee the results. Following are rough instructions for Virtmanager.

Firstly download the OVMF files for your Linux distribution. The OVMF is an EFI firmware for the virtual machine. For example, on FEdora the package is called edk2-ovmf, on Arch Linux it is called ovmf.

Then check your configuration file in /etc/libvirt/qemu.conf. The important variable is called nvram. It contains array of paths which should point to the needed files. There is usually some default commented value, make sure that the variable is uncommented and points to existing files. This may be different for every distro.

Now launch the machine and connect to the serial console if needed. The installation should be fully automatic, you can monitor its progress. If you want to see logs of Anaconda or access the shell, you will have to do it through the virtual  machine. Switch to the second console for shell, third console for logs and fourth console for storage logs.

## What is actually done?

As mentioned, the aim of this project is to automatically create images which can be later transfered to USB drives and handed to participants of Linux workshops at Agora. The installation is based on Fedora 29 Mate Spin. The image is composed of three partitions, one BIOS boot partition taking 1 MB, one root partition taking cca 17 GB and one data partition taking rest of the provided disk. Boot and root partitions are formatted as EXT4, data partition as FAT32. The purpose of FAT32 partition is to maximize usage of provided space on USB drive and exchange of data with non-Linux world.

Following additional changes are applied:

- added RPM Fusion free and nonfree package repositories

- added custom repository with Festival Czech voices and one specific for this distro so that we can push updates

- system locale is set to Czech, keyboard to Czech qwertz, Czech and Slovak language packs are downloaded

- the time zone is set to Europe/Prague

- Orca screenreader starts at login screen and also after login for current and also newly created users

- Orca configuration is slightly modified, see below

- QT accessibility is enabled

- accessibility of applications ran with sudo is enabled

- Grub tune is added

- LIOS OCR software is installed, so far not as a package

- Mate is downgraded because of problems with Mate Panel, Mate packages are also excluded to prevent upgrades

- A short help is placed into home directory (napoveda.txt)

- some keyboard shortcuts are added, see below

- default Firefox profile is used with custom home page and bookmarks

- Caja audio previews are disabled

- file associations are modified so that audio files open in VLC

- Festival is enabled with Czech voice, however, behaves strangely on physical hardware

- /etc/systemd/system.conf is modified to speed up shutdown



- extra packages are preinstalled

    - gimagereader QT version

    - pidgin with support for Facebook and Skype Web

    - Xsane

    - various firmware and software for broader hardware support including wireless cards, printers, scanners, graphic cards

    - Exfat support through Fuse

    - Audacity

    - Soundconverter

    - Tesseract OCR enging with English, Czech and Slovak data

    - Ifuse for support of Apple storage

    - Git, Curl, Wget, Sed

    - VLC player

    - Java-atk-wrapper, Qt-at-spi

- Following packages were removed:

    - Exaile

    - Hexchat

    - Filezilla

    - Gnote

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