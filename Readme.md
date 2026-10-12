# What is it about?

This repository contains resources concerning unofficial Linux distribution aimed at visually impaired users.
This distribution is called Vojtux.
The name is based on first name of the main contributor; Vojtech.

The repo currently contains Kickstart files to create a live media image with accessible environment.
This image can be later used to install the system on a device.
The repo contains kickstart files to build the live image with English language.
It also contains  files which are used to build RPM packages which are not part of Fedora and they are used in this distro.
Resulting RPM packages are present in the [Vojtux Copr repository](https://copr.fedorainfracloud.org/coprs/tyrylu/vojtux-apps/).

The live media is currently based on Fedora 43.

## Principles of Vojtux

The ultimate vision of Vojtux is "NO VOJTUX NEEDED!" because Fedora will be fully accessible.

We are not there yet, but I think we are relatively close.
That is where Vojtux comes and tries to fill the gap.
Here I describe principles which I see as crucial for this project to become maintainable and usable.

### Stay as close to the original distro as possible

Vojtux provides only basic enhancements to the original distribution (Fedora Mate Spin at the moment).
No redesigns, no special overlays, only minimal custom desktop configuration.
The goal is to minimize maintenance costs of the project.

### Do not fix broken things unless it is trivial

Linux desktop accessibility is not perfect, let's face it.
Every desktop environment has its problems, smaller or bigger.
Vojtux is not here to fix them all.
The approach is to delegate most fixes to the upstream project.
The logic behind this decision is simple; if Vojtux fixes it, it becomes the "maintainer" of the fix.
And I believe there is a limit of number of fixes which can be maintained in such a distro.
Contrary, when reported upstream, then everyone will benefit from the fix and hopefully it will contribute to accessibility knowledge of developers.

### Distribute modifications in form of packages

The goal is to distribute majority of Vojtux customizations as separate packages (RPMin this case).
That means that each customization should have clear boundaries and it should be reusable by any other distribution.

## Downloading the prebuilt image

Vojtux releases can be found [here](https://github.com/vojtapolasek/vojtux/releases).
Github does not allow to publish binary files larger tha 2GiB.
The Vojtux live image is bigger, therefore I host it on my own hosting.
There is always a checksum attached.
You can verify if the image matches the checksum by downloading both files into one directory and running the following command from the terminal while being in the same directory:

```bash
sha256 -c <file_name_endinging_with.sha256>
```

## Known issues

Known issues are listed [here](https://github.com/vojtapolasek/vojtux/issues?q=state%3Aopen%20label%3A%22Known%20issue%22).

## Building live media ISO

*Warning!* The Czech kickstart file is outdated!

This repository is currently transitioning from the state where customizations were present in the kickstart file to a state where most of customizations will be packaged as RPMs.
This is currently implemented for the English kickstart file, Czech kickstart file is not maintained right now.
In future, it will get updated or deleted entirely.

The kickstart file is inspired by the Fedora Mate spin.
The Mate environment is chosen because it is lightweight and its accessibility is prety good.

Kickstart documentation can be found at <https://pykickstart.readthedocs.io/en/latest/kickstart-docs.html>.

### Prerequisites

A host with a container runtime able to run one privileged container: **podman** (preferred, Fedora native) or **docker**.
The host's own Fedora release does not need to match the target release and no build packages (lorax, anaconda) are needed on the host.

```bash
sudo dnf install podman
```

The target release is defined in the [RELEASE](RELEASE) file at the repository root.
The container base image tag, `--releasever` and the ISO name are all derived from it.

### Containerized build (primary)

Clone this repo and run the build script from its root:

```bash
git clone https://github.com/vojtapolasek/vojtux
cd vojtux
containerbuild/build.sh
```

The script reads `RELEASE`, builds the toolchain container image `vojtux-build:<release>` from `containerbuild/Containerfile` (based on `registry.fedoraproject.org/fedora:<release>`, so the build toolchain always matches the target release), and runs `ksflatten` and `livemedia-creator --make-iso --no-virt` inside a privileged container (required for loop devices and mounts).

The resulting ISO is written to `containerbuild/output/vojtux_<release>.iso`.
Set `OUTPUT_DIR=/some/dir` to write it elsewhere.

To use docker instead of podman:

```bash
CONTAINER_TOOL=docker containerbuild/build.sh
```

**Note:** CI exercises only the podman runtime; the docker invocation mirrors the previously documented docker build but is not automatically tested. If you hit a docker-specific problem, please report it.

If you want to check that `ks/repos.ks` is in sync with `RELEASE` (relevant when rebasing to a new Fedora release), run:

```bash
containerbuild/check-release.sh
```

### Host-local build (alternative, not the maintained contract)

Building directly on the host is still possible, but the host must run Fedora matching the target release (the toolchain has to match the target release) and provide `lorax-lmc-novirt`: install it with `sudo dnf install lorax-lmc-novirt`, flatten the kickstart with `ksflatten -c ks/vojtux_en.ks -o vojtux.ks` and run `sudo livemedia-creator --make-iso --no-virt --iso-only --anaconda-arg="--noselinux" --iso-name vojtux_$(cat RELEASE).iso --project vojtux --releasever $(cat RELEASE) --ks vojtux.ks --tmp live/tmp`. Prefer the containerized build above.

## Docker build

**Removed.** The `dockerbuild/` directory was superseded by `containerbuild/`, which supports docker through runtime selection (`CONTAINER_TOOL=docker containerbuild/build.sh`). See [Building live media ISO](#building-live-media-iso).

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

- a script for toggling physical monitor is added

- a sound theme is added, [source](https://github.com/coffeeking/Linux-a11y-sound-theme)

## Added shortcuts

- Alt-Super-o - restart orca

- Alt-Super-up/down - change system volume

- Alt-Super-left - mute/unmute system volume

- Alt-Super-f - Firefox

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
