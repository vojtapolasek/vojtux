# What is it about?

This repository contains resources concerning unofficial Linux distribution aimed at visually impaired users. This distribution is called Fegora, because it is based on Fedora and it was presented at Agora event. Agora is an event in Czech Republic, where workshops about information technology for visually impaired are presented.

The repo currently contains Kickstart files to create a live media image with accessible environment. This image can be later used to install the system on a device.

## Building live media ISO

The kicstart file is inspired by the FFedora Mate spin. The Mate environment is chosen because it is lightweight and its accessibility is prety good.

Kickstart documentation can be found at <https://pykickstart.readthedocs.io/en/latest/kickstart-docs.html>.

Building of this image requires Fedora. So how to build it?

1. sudo dnf install livecd-tools

2. clone this repo

3. create a directory structure to store cache and tmp files (optional)

    1. mkdir -p live/tmp

    2. mkdir live/cache

4. sudo livecd-creator -c fegora_live_cz.ks -p -d -t <absolute_path_to_tmp_dir> --cache <absolute_path_to_cache_dir> -f fegora_33_cz

    - if you did not create your own cache and tmp dir, you can leave out the -t and --cache arguments


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

