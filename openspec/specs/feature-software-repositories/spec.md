# feature-software-repositories Specification

## Purpose
Repositories and update channels configured so users install and update without extra setup.
## Requirements
### Requirement: Third-party repositories configured in the image
The shipped image SHALL have RPM Fusion free and nonfree repositories (with their updates) configured with GPG keys imported, so codec- and driver-bearing packages are installable. Delivered by `ks/repos.ks` repo definitions and GPG imports in `ks/vojtux_common.ks` `%post`. Verified by: none.

#### Scenario: Install an RPM Fusion package
- **WHEN** a user installs a package that only exists in RPM Fusion
- **THEN** dnf resolves and installs it without the user adding repositories

### Requirement: Vojtux package updates via Copr
The shipped image SHALL enable the `tyrylu/vojtux-apps` Copr repository so Vojtux-provided packages (lios, ocrdesktop, toggle-monitor, vojtux-settings, a11y-sound-theme, docs) receive updates without an image rebuild. Delivered by the Copr repo entry in `ks/repos.ks` and `dnf copr enable -y tyrylu/vojtux-apps` in `%post`. Verified by: none.

#### Scenario: Update a Vojtux package
- **WHEN** `dnf upgrade` is run on the installed system
- **THEN** newer versions of Vojtux packages are available from the vojtux-apps repository

### Requirement: Build-time repositories pinned to the target Fedora release
The kickstart SHALL pin Fedora, updates and RPM Fusion repository definitions to the Fedora release being built (currently 43), so the build is reproducible for that release. Delivered by `ks/repos.ks`. Part of the Fedora rebase checklist in `live-image-build`.

#### Scenario: Build targets the declared release
- **WHEN** the image is built for release N
- **THEN** every repository line in `ks/repos.ks` references release N

