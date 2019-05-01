# What is it about?

This repository contains resources related to presentation of modified version of Fedora 29 on the Agora Spring event 2019 in Brno. During this events there will be two runs of two workshops focused on introducing Linux and its accessibility features to blind and visually impaired people.

During both workshops it is planed to give a USB drive to participants. This drive will contain working installation of Fedora 29 with various accessibility tweaks to suit the target audience.

## Building installation ISO

The main technical idea is to build an ISO image which will perform automatic partitioning of the USB drive and installation of Fedora. Everything powered by Kickstart. So far it is based on Fedora Everything net install image located at <https://mirror.karneval.cz/pub/linux/fedora/linux/releases/29/Everything/x86_64/iso/>.

Kickstart documentation can be found at <https://pykickstart.readthedocs.io/en/latest/kickstart-docs.html>.


Clone this repository and modify the ks.cfg file as needed. then run

sudo ./prepare_iso.sh

and the new file fegora.iso will be created in the same directory. The script will download the ISO and perform file verification. The script needs fuseiso and mkisofs utilities to be present.

