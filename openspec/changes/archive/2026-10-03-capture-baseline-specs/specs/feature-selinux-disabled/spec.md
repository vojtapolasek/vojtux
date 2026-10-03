# feature-selinux-disabled

## ADDED Requirements

### Requirement: SELinux disabled in the image
The built image SHALL have SELinux disabled, chosen so that SELinux policy denials never block the accessibility stack during live-boot and assisted installation. Delivered by the `selinux --disabled` directive in `ks/vojtux_common.ks`. Note: the Readme's claim of "permissive" does not match the implemented "disabled" state (see Needs resolution in the capturing change). Verified by: none.

#### Scenario: Check SELinux state on the live image
- **WHEN** `getenforce` is run on the shipped image
- **THEN** it reports `Disabled`
