# feature-lios

## ADDED Requirements

### Requirement: LIOS OCR available with shortcut
The system SHALL ship the LIOS (Linux-Intelligent-Ocr-Solution) application, built from the pinned upstream fork commit, and bind it to Alt+Super+L so printed material can be OCR'd on demand. Delivered by the `lios` RPM (source pinned to zendalona/lios commit `b1fe5e29968a695edabc500d4c4f7e5eb05de01a`, keybinding in `distro.d` via the package). Verified by: none.

#### Scenario: Launch LIOS
- **WHEN** the user presses Alt+Super+L
- **THEN** LIOS starts and can capture and recognize screen regions
