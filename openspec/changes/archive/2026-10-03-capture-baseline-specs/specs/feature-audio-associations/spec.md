# feature-audio-associations

## ADDED Requirements

### Requirement: FLAC files open in VLC
For newly created users, the system SHALL associate the `audio/flac` MIME type with VLC as the default and preferred application. No other audio MIME types have associations in the current implementation; the Readme's broader "audio files open in VLC" claim is unresolved (see Needs resolution in the capturing change). Delivered by `downloads/mimeapps.list` copied to `/etc/skel/.config/` in `ks/vojtux_en.ks` `%post`. Verified by: none.

#### Scenario: Open a FLAC file
- **WHEN** a new user activates a `.flac` file in the file manager
- **THEN** VLC opens the file

#### Scenario: Other audio formats today
- **WHEN** a new user activates an audio file of another type (e.g. `.mp3`)
- **THEN** the desktop default applies; no Vojtux association is set for it
