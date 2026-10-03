# feature-panel-layout

## ADDED Requirements

### Requirement: Predictable MATE panel for the live user
The live image SHALL present a locked, predictable MATE panel layout: top panel with menu bar, advanced-mate-menu, notification area, clock and volume control; bottom panel with show-desktop and window list. Delivered by the kickstart `%post` writing `/etc/dconf/db/local.d/00-panel-live-user`. This override exists only on the live media (mate-menu configuration could not be packaged, see vojtux-settings changelog). Verified by: none.

#### Scenario: Live desktop panel
- **WHEN** the live image desktop loads
- **THEN** the panel contains the listed applets at their defined positions and the applets are locked against accidental movement
