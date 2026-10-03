# feature-speech-dispatcher Specification

## Purpose
Speech output works out of the box through the espeak-ng module.
## Requirements
### Requirement: espeak-ng module enabled
The system SHALL ship speech-dispatcher with the espeak-ng output module enabled so that assistive speech works out of the box. Delivered by the kickstart `%post` section, which uncomments `AddModule "espeak-ng"` in `/etc/speech-dispatcher/speechd.conf`. Verified by: manual TC1 in TESTING.md (indirectly, via audible Orca speech).

#### Scenario: Speech available after boot
- **WHEN** the system has booted and a screen reader requests speech
- **THEN** speech-dispatcher serves it through the espeak-ng module without further configuration

