# feature-monitor-toggle Specification

## Purpose
A shortcut to power the physical monitor off and on.
## Requirements
### Requirement: Physical monitor power toggle
The system SHALL provide `/usr/bin/monitor-toggle` bound to Alt+Super+M so the physical monitor can be switched off and on without reaching for hardware buttons (the sighted helper or blind user keeps the session). Delivered by the `toggle-monitor` RPM (script + dconf keybinding `custom10`). Verified by: none.

#### Scenario: Toggle monitor off and back on
- **WHEN** the user presses Alt+Super+M
- **THEN** the monitor powers off, and pressing the same shortcut again powers it back on

