# feature-login-sound Specification

## Purpose
The login screen of an installed system is guaranteed to be audible.
## Requirements
### Requirement: Login screen volume unmuted at 50 percent
The system SHALL ensure the login screen of an installed system can produce sound by unmuting the master volume and setting it to 50% immediately before Orca starts there. The live medium auto-logs in and does not present an interactive login screen, so this behavior is chiefly exercised after installation. Delivered by `/usr/local/bin/orca-login-wrapper` (`amixer -c 0 set Master playback 50% unmute`), created in the kickstart `%post`. Verified by: none (manual check after installation).

#### Scenario: Silent hardware reaches the login screen
- **WHEN** an installed Vojtux system boots with the master volume muted or turned down and the login screen appears
- **THEN** the master volume is set to 50% and unmuted before Orca starts, so the startup announcement is audible

