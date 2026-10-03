# feature-docs-handouts Specification

## Purpose
Vojtux documentation shipped as packages and reachable from the user's home.
## Requirements
### Requirement: Documentation reachable from home
The English image SHALL make the Vojtux handout and keyboard-shortcut list reachable at `~/documentation` for the live user and for newly created users. Delivered by the `vojtux-docs-en` RPM (`handout.md`, `keyboard_shortcuts.txt`) plus symlinks from `/etc/skel/documentation` and `/home/liveuser/documentation` created in `ks/vojtux_en.ks` `%post`. Verified by: none.

#### Scenario: Look up a shortcut offline
- **WHEN** a user opens `~/documentation` on the live image
- **THEN** the handout and the keyboard shortcut list are present and readable

### Requirement: Documentation packaged for reuse
Vojtux documentation SHALL be distributed as RPM packages (`vojtux-docs-en` in `rpm/`, `vojtux-docs-cs` in `specs/`) following the package-first principle, rather than copied loose files.

#### Scenario: Reuse docs on another system
- **WHEN** another Fedora system installs the docs package
- **THEN** the documentation is available under `/usr/share/doc/vojtux-docs-*` without the Vojtux image

