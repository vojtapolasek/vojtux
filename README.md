# What is it about?

This repository contains resources concerning unofficial Linux distribution aimed at visually impaired users. This distribution is called Fegora, because it is based on Fedora and it was presented at Agora event. Agora is an event in Czech Republic, where workshops about information technology for visually impaired are presented.

The repo currently contains Kickstart files to create a live media image with accessible environment. This image can be later used to install the system on a device.

## Building live media ISO

The kickstart file is inspired by the Fedora Mate spin. The Mate environment is chosen because it is lightweight and its accessibility is prety good.

Kickstart documentation can be found at <https://pykickstart.readthedocs.io/en/latest/kickstart-docs.html>.

Building of this image requires Fedora. So how to build it?

1. sudo dnf install lorax-lmc-novirt

2. clone this repo

3. create a directory structure to store cache and tmp files (optional)

    - mkdir -p live/tmp

5. ksflatten -c <input_kickstart_file.ks> -o <output_kickstart_file.ks>

    - this makes sure that all includes will be handled correctly

5. sudo livemedia-creator --make-iso --no-virt --ks <ks_file.ks --tmp live/tmp --anaconda-arg="--noselinux" 

    - if you did not create your own temporary directory, you can leave out the --tmp argument


## What is actually done?

The result will be stored in the tmp directory in a folder with randomly generated name. In this folder there will be folder images and in this folder there will be a file called anaconda.iso. The live image is based on Fedora Mate spin.

Following additional changes are applied:

- added RPM Fusion free and nonfree package repositories

- added custom repository with Festival Czech voices and one specific for this distro so that we can push updates

- system locale is set to Czech, keyboard to Czech qwertz, Czech and Slovak language packs are downloaded

- the time zone is set to Europe/Prague

- Orca screenreader starts at login screen and also after login for current and also newly created users

- Orca configuration is slightly modified, see below

- QT accessibility is enabled

- accessibility of applications run with sudo is enabled

- Grub tune is added, although it does not work in every case

- LIOS OCR software is installed

- A short help in Czech is placed into home directory (handout.html), list of keyboard shortcuts (klavesove_zkratky.txt)

- some keyboard shortcuts are added, see below

- Caja audio previews are disabled

- file associations are modified so that audio files open in VLC

- Festival is enabled with Czech voice, however, behaves strangely on physical hardware

- /etc/systemd/system.conf is modified to speed up shutdown

- Selinux policiy is set to permissive

- Slick greeter is replaced with Lightdm GTK greeter because of problems with Orca not starting after login

- Tmux is configured with special keyboard shortcuts inspired by the Byobu project

- extra packages are preinstalled

    - gimagereader QT version

    - pidgin with support for Facebook and Skype Web

    - Xsane

    - various firmware and software for broader hardware support including wireless cards, printers, scanners, graphic cards

    - Audacity

    - Soundconverter

    - Tesseract OCR engine with English, Czech and Slovak data

    - Ifuse for support of Apple storage

    - jmtpfs for support of MTP

    - Git, Curl, Wget, Sed

    - VLC player

    - Qt-at-spi

    - Tmux for better working with consoles

    - Chromium

- Following packages were removed:

    - Exaile

    - Hexchat

    - Filezilla

    - Gnote

- there is a special script which ensures that the sound is not muted and is at 50% of volume on login screen

- a script for toggling physical monitor is added, functionality not tested

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

- ALT-Super-m - vypnutí / zapnutí monitoru

