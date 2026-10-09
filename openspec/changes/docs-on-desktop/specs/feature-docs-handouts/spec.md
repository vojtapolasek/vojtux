# feature-docs-handouts

## MODIFIED Requirements

### Requirement: Documentation reachable from home
The English image SHALL make the Vojtux handout and keyboard-shortcut list reachable at `~/documentation` and at `~/Desktop/documentation` for the live user and for newly created users. Delivered by the `vojtux-docs-en` RPM (`handout.md`, `keyboard_shortcuts.txt`) plus symlinks from `/etc/skel/documentation`, `/home/liveuser/documentation`, `/etc/skel/Desktop/documentation` and `/home/liveuser/Desktop/documentation` created in `ks/vojtux_en.ks` `%post`. Verified by: none.

#### Scenario: Look up a shortcut offline
- **WHEN** a user opens `~/documentation` on the live image
- **THEN** the handout and the keyboard shortcut list are present and readable

#### Scenario: Discover documentation from the desktop
- **WHEN** a new user reaches the desktop after login and browses the desktop icons
- **THEN** a `documentation` entry is present and opens the handout and the keyboard shortcut list
