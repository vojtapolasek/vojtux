# feature-preinstalled-apps Specification

## Purpose
The applications and hardware support a blind user needs, preinstalled.
## Requirements
### Requirement: Accessible applications ready to use
The image SHALL preinstall the applications a blind user needs for everyday work so nothing must be downloaded first: Audacity, soundconverter, VLC, Chromium, Pidgin, Xsane, tmux, timidity++, unrar, nano, pandoc, ocrmypdf, plus core CLI tools (git, curl, wget, sed) and sox. Delivered by `ks/vojtux_common.ks` `%packages`. Verified by: none.

#### Scenario: Use a core application offline
- **WHEN** the live image runs without network access
- **THEN** the listed applications are installed and start without any installation step

### Requirement: Broad hardware support out of the box
The image SHALL preinstall firmware and driver/printer/scanner stacks (hardware-support group, gutenprint, cups-filters, foomatic-db, splix, hplip, libsane-hpaio, nouveau/dummy X drivers) plus Apple/MTP storage bridges (ifuse, jmtpfs) so common peripherals work without manual setup. Delivered by `ks/vojtux_common.ks` `%packages`.

#### Scenario: Common printer or scanner attached
- **WHEN** a common USB printer or scanner is attached to the live system
- **THEN** the necessary drivers/filters are already installed for CUPS or SANE to use the device

### Requirement: Remote assistance tool included
The image SHALL include tmate so a remote helper can be given terminal access for support. It is installed unconfigured; the user decides when to share a session. Delivered by `ks/vojtux_common.ks` `%packages` ("remote support" entry). Verified by: none.

#### Scenario: Support session requested
- **WHEN** the user runs `tmate`
- **THEN** ssh session-sharing URLs are produced that a helper can connect to

