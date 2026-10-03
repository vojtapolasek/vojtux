# feature-keybindings Specification

## Purpose
Desktop-wide keyboard shortcuts that keep common actions reachable without a mouse.
## Requirements
### Requirement: Generic desktop shortcuts
The system SHALL provide the following desktop-wide keyboard shortcuts for all users: Alt+Super+F starts Firefox; Primary+Alt+T launches mate-terminal; Super+Home opens the home folder in Caja; Alt+Super+O restarts Orca. Feature-owned shortcuts (monitor toggle, LIOS, ocrdesktop) are specified in their own capabilities. Delivered by `vojtux-settings` dconf file `distro.d/03-keybindings`. A dedicated screen-reader-start shortcut is intentionally absent because Fedora 43 ships one by default.

#### Scenario: Start Firefox from anywhere
- **WHEN** the user presses Alt+Super+F on the desktop
- **THEN** Firefox launches

#### Scenario: Restart Orca
- **WHEN** Orca misbehaves and the user presses Alt+Super+O
- **THEN** Orca restarts (`orca -r`)

### Requirement: Volume shortcuts with audible confirmation
The system SHALL provide Alt+Super+Up / Alt+Super+Down to change the default audio output volume in 5% steps and Alt+Super+Left to toggle mute, each accompanied by an audible confirmation sound. Delivered by `vojtux-settings` `distro.d/03-keybindings` using `wpctl` and `play /usr/share/sounds/freedesktop/stereo/audio-volume-change.oga`. Verified by: none.

#### Scenario: Volume up
- **WHEN** the user presses Alt+Super+Up
- **THEN** the default sink volume increases by 5% and the volume-change sound plays so the change is perceivable

#### Scenario: Mute toggle
- **WHEN** the user presses Alt+Super+Left
- **THEN** the default sink mute state toggles and the confirmation sound plays

