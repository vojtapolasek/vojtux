# What is it about?

This repository contains resources concerning unofficial Linux distribution aimed at visually impaired users.
This distribution is called Vojtux.
The name is based on first name of the main contributor; Vojtech.

The repo currently contains Kickstart files to create a live media image with accessible environment.
This image can be later used to install the system on a device.
The repo contains kickstart files to build the live image with English language.
It also contains  files which are used to build RPM packages which are not part of Fedora and they are used in this distro.
Resulting RPM packages are present in the [Vojtux Copr repository](https://copr.fedorainfracloud.org/coprs/tyrylu/vojtux-apps/).

The live media is currently based on Fedora 41.

## Building live media ISO

*Warning!* The Czech kickstart file is outdated!

This repository is currently transitioning from the state where customizations were present in the kickstart file to a state where most of customizations will be packaged as RPMs.
This is currently implemented for the English kickstart file, Czech kickstart file is not maintained right now.
In future, it will get updated or deleted entirely.

The kickstart file is inspired by the Fedora Mate spin.
The Mate environment is chosen because it is lightweight and its accessibility is prety good.

Kickstart documentation can be found at <https://pykickstart.readthedocs.io/en/latest/kickstart-docs.html>.

Building of this image requires Fedora.
It is strongly recommended to use Fedora version matching the one you are going to build.
So if you are going to build a live media based on Fedora 41, it is strongly recommended to do it from Fedora 41 environment.

So how to build it?

1. sudo dnf install lorax-lmc-novirt

2. clone this repo

3. create a directory structure to store cache and tmp files (optional)

    - mkdir -p live/tmp

4. ksflatten -c <input_kickstart_file.ks> -o <output_kickstart_file.ks>

    - choose ks/vojtux_cs.ks or ks/vojtux_en.ks as an input file, based on your language choice

    - this makes sure that all includes will be handled correctly

    ```bash
    sudo livemedia-creator --make-iso --no-virt --iso-only  --anaconda-arg="--noselinux" --iso-name vojtux_41.iso --project vojtux --releasever 41 --ks <output_kickstart_file.ks> --tmp live/tmp
    ```

    - --make-iso creates ISO image. Note that you can create multiple things with livemedia-creator.

    - --no-virt uses local Anaconda to perform the installation without spinning up virtual machine. This is probably not mandatory, but I chose this approach because I am actually building the image within virtual machine running Fedora.

    - --iso-only - after the process finishes, delete all artifacts except for the resulting ISO image. You may omit this if you need to inspect intermediate artifacts.

    - --anaconda-arg="--noselinux" disables selinux during the installation, it was causing problems.

    - --iso-name vojtux_41.iso provides name for the resulting ISO image

    - --project vojtux project name, this is used as image label and it is visible in the boot menu

    - --releasever 41 this is also visible in the boot menu

    - --ks <output_kickstart_file.ks> use the kickstart file created in previous steps

    - --tmp live/tmp optional argument if you want to use your own defined tmp directory

## Docker build

There is a simple build.sh script included to show the sequence that I used to build the image.

```
./dockerbuild/build.sh
```

Which should end in something like:

```
sudo find ./dockerbuild/output -name vojtux_38.iso
./dockerbuild/output/vojtux_38.iso
```

Your `vojtux_38.iso` should be listed as above.

## What is actually done?

The result will be stored in the tmp directory in a folder with randomly generated name.
In this folder there will be a file called according to the --iso-name parameter.

Following additional changes are applied:

- added RPM Fusion free and nonfree package repositories

- added custom repository with Festival Czech voices and one specific for this distro so that we can push updates

- in case of Czech version:

    - system locale is set to Czech, keyboard to Czech qwertz, Czech and Slovak language packs are downloaded

    - the time zone is set to Europe/Prague

- Orca screenreader starts at login screen and also after login for current and also newly created users

- Orca configuration is slightly modified, see below

- QT accessibility is enabled

- accessibility of applications run with sudo is enabled

- Grub tune is added, although it does not work in every case

- LIOS OCR software is installed

- some documentation is placed within the home directory (short handout + list of keyboard shortcuts)

- some keyboard shortcuts are added, see below

- Caja audio previews are disabled

- file associations are modified so that audio files open in VLC

- Festival is enabled with Czech voice, however it behaves strangely on physical hardware

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

    - Tmux to enhance working with consoles

    - Chromium

- Following packages were removed:

    - Exaile

    - Hexchat

    - Filezilla

    - Gnote

- there is a special script which ensures that the sound at the login screen is not muted and is at 50% of volume

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

