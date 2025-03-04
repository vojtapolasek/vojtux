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

1. Install prerequisites.

    ```bash
    sudo dnf install lorax-lmc-novirt
    ```

2. clone this repo

    ```bash
    git clone https://github.com/vojtapolasek/vojtux
    cd vojtux
    ```

3. create a directory structure to store cache and tmp files (optional)

    ```bash
    mkdir -p live/tmp
    ```

4. Create the final kickstart file, blending several kickstarts together.

    ```bash
    ksflatten -c ks/vojtux_en.ks -o vojtux.ks
    ```

5. Build the image

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

    - --ks vojtux.ks use the kickstart file created in previous steps

    - --tmp live/tmp optional argument if you want to use your own defined tmp directory

## Docker build

**Note: currently not maintained, will be updated soon.**

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

- added vojtux-apps repository specific for Vojtux distro so that it is easier to push updates

- Orca screenreader starts at login screen and also after login for current and also newly created users

- QT accessibility is enabled

- Grub tune is added, although it does not work in every case

- LIOS OCR software is installed

- some documentation is placed within the home directory (short handout + list of keyboard shortcuts)

- some keyboard shortcuts are added, see below

- Caja audio previews are disabled

- file associations are modified so that audio files open in VLC

- /etc/systemd/system.conf is modified to speed up shutdown

- Selinux policy is set to permissive

- Slick greeter is replaced with Lightdm GTK greeter because of problems with Orca not starting after login

- Tmux is configured with special keyboard shortcuts inspired by the Byobu project

- extra packages are preinstalled

    - pidgin with support for Facebook

    - Xsane

    - various firmware and software for broader hardware support including wireless cards, printers, scanners, graphic cards

    - Audacity

    - Soundconverter

    - Tesseract OCR engine with English data

    - Ifuse for support of Apple storage

    - jmtpfs for support of MTP

    - Git, Curl, Wget, Sed

    - VLC player

    - Tmux to enhance working with consoles

    - Chromium

    - ocrmypdf (command line version only)

- there is a special script which ensures that the sound at the login screen is not muted and is at 50% of volume

- a script for toggling physical monitor is added, functionality not tested

- a sound theme is added, [source](https://github.com/coffeeking/Linux-a11y-sound-theme)

## Added shortcuts

- Alt-Super-o - restart orca

- Alt-Super-up/down - change system volume

- Alt-Super-left - mute/unmute system volume

- Alt-Super-f - Firefox

- Alt-Super-s toggle screenreader through Mate

- Alt-Super-l start the LIOS software

- Alt-Super-m - vypnutí / zapnutí monitoru

## Contributing

Contributions are definitely welcomed. I can imagine following ways of contribution:

- testing functionality and accessibility the live image, you can see [TESTING.md](list of tests) for inspiration

- testing functionality and accessibility of Vojtux after being installed

- creating new issues reporting problems or suggesting new features

- announcing accessibility-related bugs to authors of the relevant component

- contributing spec files for new relevant packages which could be shipped in the [vojtux-apps](https://copr.fedorainfracloud.org/coprs/tyrylu/vojtux-apps/) repo

- contributing changes to documentation

- contributing changes to kickstart files

- spreading the word about the distribution
