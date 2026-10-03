# feature-a11y-sound-theme Specification

## Purpose
Accessible sound theme so desktop events are perceivable through sound.
## Requirements
### Requirement: linux-a11y sound theme shipped and selected
The system SHALL ship the linux-a11y sound theme (from upstream coffeeking/linux-a11y-sound-theme) and select it with event and input-feedback sounds enabled. Delivered by the `a11y-sound-theme` RPM (theme in `/usr/share/sounds/linux-a11y`, dconf file `distro.d/12-a11y`). Verified by: none.

#### Scenario: Desktop emits event sounds
- **WHEN** the desktop triggers a UI event sound
- **THEN** the sound comes from the linux-a11y theme and event sounds are enabled by default

