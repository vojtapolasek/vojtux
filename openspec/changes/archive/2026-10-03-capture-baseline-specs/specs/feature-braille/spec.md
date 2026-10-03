# feature-braille

## ADDED Requirements

### Requirement: Braille display support
The system SHALL include brltty so that connecting a supported braille terminal makes braille output available without additional installation. Delivered by the package groups/packages pulled into `ks/vojtux_common.ks` (group added explicitly because of brltty).

#### Scenario: Braille display connected
- **WHEN** a supported braille display is connected to a running Vojtux system
- **THEN** brltty handles the device and application text becomes available on the display

### Requirement: Braille testing without hardware
The image SHALL include `brltty-xw` so braille output can be tested on systems without a physical braille device. Delivered by `ks/vojtux_common.ks` package list.

#### Scenario: Test braille output on plain hardware
- **WHEN** a tester needs to verify braille output without a physical display
- **THEN** the brltty-xw X-frontend is installed and can be used
