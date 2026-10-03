# feature-orca-autostart

## ADDED Requirements

### Requirement: Orca speaks at the login screen of installed systems
The system SHALL start the Orca screen reader when the login screen appears on a system installed from Vojtux, by registering an Orca wrapper script as the LightDM GTK greeter reader with a11y reader state enabled. The live medium itself does NOT present an interactive login screen: Fedora's livesys scripts auto-log-in the live user, so this greeter behavior is exercised after installation. Delivered by the kickstart `%post` section (`/usr/local/bin/orca-login-wrapper`, `lightdm-gtk-greeter.conf`), which carries into the installed system. Verified by: none (manual check after installation).

#### Scenario: Installed system boots to its login screen
- **WHEN** a system installed from the Vojtux image boots and the graphical login screen appears
- **THEN** Orca is running and its startup announcement ("Screen Reader on") is audible

### Requirement: Orca starts in user sessions
The system SHALL start Orca automatically for MATE user sessions for both the existing live user and newly created users. On the live medium this runs through the livesys autologin session and is what produces speech after boot. Delivered by `vojtux-settings` dconf key `org/mate/desktop/applications/at/visual exec='orca'` plus `org/mate/desktop/interface accessibility=true` (system-wide dconf database). Verified by: manual TC1 in TESTING.md (live image speech after boot).

#### Scenario: Log in to the desktop
- **WHEN** a user reaches a MATE session (live autologin or login at the greeter)
- **THEN** Orca starts without the user launching it manually

#### Scenario: New user logs in
- **WHEN** a newly created user logs in for the first time
- **THEN** Orca starts automatically for that user as well

### Requirement: Screen reader pre-enabled for GNOME sessions
If the user moves to a GNOME session, the system SHALL have the screen reader already pre-enabled so accessibility survives the session choice. Delivered by `vojtux-settings` key `org/gnome/desktop/a11y/applications screen-reader-enabled=true`.

#### Scenario: GNOME session started
- **WHEN** a GNOME session is started on a Vojtux-installed system
- **THEN** the screen reader is enabled by default

### Requirement: Greeter is LightDM GTK
The system SHALL use LightDM GTK greeter instead of slick-greeter, because slick-greeter prevented Orca from starting correctly after login. The package selection carries from the image into installed systems, where the greeter is actually seen. Delivered by `ks/vojtux_common.ks` package list (slick-greeter excluded, lightdm-gtk-greeter added). Verified by: none.

#### Scenario: Installed system login screen
- **WHEN** an installed system reaches its graphical login screen
- **THEN** the LightDM GTK greeter is used (slick-greeter is absent) and Orca autostart works with it
