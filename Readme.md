# What is it about?

This repository contains resources related to presentation of modified version of Fedora 29 on the Agora Spring event 2019 in Brno. During this events there will be two runs of two workshops focused on introducing Linux and its accessibility features to blind and visually impaired people.

During both workshops it is planed to give a USB drive to participants. This drive will contain working installation of Fedora 29 with various accessibility tweaks to suit the target audience.

## Building installation ISO

The main technical idea is to build an ISO image which will perform automatic partitioning of the USB drive and installation of Fedora. Everything powered by Kickstart. So far it is based on Fedora Everything net install image located at <https://mirror.karneval.cz/pub/linux/fedora/linux/releases/29/Everything/x86_64/iso/>.

Kickstart documentation can be found at <https://pykickstart.readthedocs.io/en/latest/kickstart-docs.html>.

Clone this repository and modify the ks.cfg file as needed. then run

sudo ./prepare_iso.sh

and the new file fegora.iso will be created in the same directory. The script will download the ISO and perform file verification. The script needs fuseiso and mkisofs utilities to be present.

## Installing from the ISO

Warning! The installation ISO will try to install to the first detected hard drive! Therefore using VM is highly recommended, I am not responsible for any loss of your data if you use real machine!

After reading the warning above, read it again and get ready some VM: Connect the USB drive which you want to use as a destination for installation and also mount the ISO created in the previous step. Make sure that the virtual machine will boot from the ISO image. I recommend you to attach a serial console to the VM and find out how to connect to it. For example, the consoles for Virtmanager can be found in the /dev/pts/ directory.

Now launch the machine and connect to the serial console if needed. The installation should be fully automatic, you can monitor its progress. If you want to see logs of Anaconda or access the shell, you will have to do it through the virtual  machine. Switch to the second console for shell, third console for logs and fourth console for storage logs.

## What is actually done?

As mentioned, the aim of this project is to automatically create images which can be later transfered to USB drives and handed to participants of Linux workshops at Agora. The installation is based on Fedora 29 Mate Spin. The image can be composed of multiple partitions, basically one boot partition, one root partition and one data partition. Boot and root partitions are formatted as EXT4, data partition as FAT32. The purpose of FAT32 partition is to maximize usage of provided space on USB drive and exchange of data with non-Linux world.

