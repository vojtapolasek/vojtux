# feature-ocrdesktop

## ADDED Requirements

### Requirement: OCR the active window
The system SHALL ship ocrdesktop (upstream chrys87/ocrdesktop, packaged at version 4.0) and bind Ctrl+Super+O to `ocrdesktop -l eng` so the content of the currently focused window is converted to text via Tesseract. The `tesserwrap` Tesseract C++ binding is built in this repository (`specs/tesserwrap.spec`) to support this toolchain. Delivered by the `ocrdesktop` RPM. Verified by: none.

#### Scenario: Read an inaccessible window
- **WHEN** the user focuses a window whose content is not exposed accessibly and presses Ctrl+Super+O
- **THEN** ocrdesktop captures the active window and provides its recognized English text
