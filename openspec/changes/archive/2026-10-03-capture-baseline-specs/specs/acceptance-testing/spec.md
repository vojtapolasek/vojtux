# acceptance-testing

## ADDED Requirements

### Requirement: Scenarios execute headless inside the live image
Automated GUI scenarios SHALL run as Gherkin scenarios written for behave with dogtail, executed **inside a running Vojtux live image** headless under LightDM, and the behave exit code SHALL decide PASS/FAIL. Delivered by `tests/runtest.sh` (`dogtail-run-headless-next --dm lightdm "behave -t <tag> ..."`), with the html-pretty report written to `/tmp/artifacts/`. Verified by: TC11 run in CI/plans.

#### Scenario: Run one tagged scenario
- **WHEN** `runtest.sh <tag>` is executed on the live system
- **THEN** behave runs only scenarios carrying that tag inside the headless session and returns zero only if they all pass

### Requirement: Live image provisioned for testing
The test plan SHALL provision the image under test as a libvirt virtual machine and copy the repository into it before execution. Delivered by `plans/vojtux.fmf` (prepare: `tests/vojtux_provision/setup.sh`, rsync into `liveuser@vojtux`), with VM/network definitions in `tests/vojtux_provision/`.

#### Scenario: Plan execution starts from scratch
- **WHEN** the tmt plan runs on a clean executor
- **THEN** a Vojtux VM is provisioned, the repo is synced into it, and tests execute over ssh

### Requirement: One-time harness bootstrap inside the image
The first test run inside a freshly booted image SHALL bootstrap the automation environment once: create a `test` user with passwordless sudo, install pip/behave/dogtail/behave-html-pretty-formatter, and enable toolkit-accessibility for the test user; subsequent runs skip the bootstrap. Delivered by `tests/runtest.sh` guarded by `/tmp/automation_setup_done`.

#### Scenario: Second run is fast
- **WHEN** `runtest.sh` is executed a second time in the same boot
- **THEN** the setup section is skipped because the marker file exists

### Requirement: Scenario-to-automation-id mapping
Automated scenarios SHALL carry a `@TCnn` behave tag corresponding to a tmt test that invokes `runtest.sh` with that tag. Current state: exactly one tmt test is wired (`/TC1` executing tag `TC11`, the Firefox shortcut); id drift is recorded as Needs resolution. Delivered by `tests/main.fmf` and `tests/features/scenarios/1_general.feature`.

#### Scenario: Wired test executes
- **WHEN** tmt runs test `/TC1`
- **THEN** the scenario tagged `@TC11` executes inside the live VM and its result is reported

### Requirement: Manual test plan is the fallback source of truth
Verification steps not covered by automation SHALL be maintained as numbered test cases (TC1...) with exact steps and demo videos in `TESTING.md`, and feature specs reference them via "Verified by" notes. Current state: the manual plan is the primary coverage; its "no automation exists" preamble is outdated (Needs resolution).

#### Scenario: Unautomated behavior is still specified
- **WHEN** a feature has no automated scenario
- **THEN** TESTING.md either documents a manual TC for it or the gap is consciously known (feature spec says "Verified by: none")
