# feature-disable-caja-previews Specification

## Purpose
Caja does not play audio previews while a user browses files.
## Requirements
### Requirement: Caja sound previews disabled
The system SHALL disable audio preview playback in Caja so that navigating files cannot unexpectedly play sounds. Delivered by the `vojtux-settings` dconf file `distro.d/02-panel` setting `org/mate/caja/preferences preview-sound='never'` (the file is named 02-panel but configures Caja). Verified by: none.

#### Scenario: Browse audio files without playback
- **WHEN** a user moves the selection through audio files in Caja
- **THEN** no preview sound is played

