# Capture baseline specifications for Vojtux

## Why

The repository predates OpenSpec and has no specifications, so agents and contributors have no agreed answer to "what does Vojtux do?". This change captures the **current, actual behavior** of the distribution and its tooling as OpenSpec specs, giving every future change a baseline to write deltas against.

## What Changes

- Introduce one `feature-*` capability per user-visible Vojtux feature (accessibility, OCR, desktop behavior, shipped content).
- Introduce two infrastructure capabilities: `acceptance-testing` (test harness and current coverage) and `live-image-build` (kickstart composition, build invocation, Fedora rebase checklist, manual release practice).
- No code changes. This change only adds planning artifacts under `openspec/`.
- Divergences found during capture are recorded below instead of being silently encoded as correct behavior.

## Capabilities

### New Capabilities

- `feature-orca-autostart`: Orca starts at the login screen of an installed system (LightDM GTK greeter reader hook) and in user sessions for current and new users; screen reader pre-enabled for GNOME sessions too. The live medium auto-logs in, so the greeter path applies after installation.
- `feature-speech-dispatcher`: espeak-ng module enabled in speech-dispatcher during image build.
- `feature-braille`: brltty braille support, plus brltty-xw for testing braille output without a physical device.
- `feature-a11y-sound-theme`: linux-a11y sound theme shipped and selected via dconf.
- `feature-login-sound`: login-screen master volume of an installed system forced unmuted at 50% before Orca starts.
- `feature-keybindings`: generic desktop shortcuts (volume up/down with audible feedback, mute, Firefox, terminal, home folder, restart Orca).
- `feature-lios`: LIOS OCR application with its own keybinding.
- `feature-ocrdesktop`: ocrdesktop active-window OCR with its own keybinding.
- `feature-monitor-toggle`: script and keybinding to toggle the physical monitor.
- `feature-tmux-profile`: tmux configured with Byobu-inspired shortcuts for new users.
- `feature-selinux-disabled`: SELinux disabled in the built image via kickstart directive.
- `feature-audio-associations`: audio MIME associations shipped in /etc/skel (currently only FLAC to VLC).
- `feature-disable-caja-previews`: Caja sound preview disabled.
- `feature-panel-layout`: MATE panel layout override for the live user (applets, locking, positions).
- `feature-preinstalled-apps`: applications and firmware preselected for accessibility and hardware coverage, including tmate for remote assistance.
- `feature-software-repositories`: Fedora/RPM Fusion repositories pinned for the target release plus the vojtux-apps Copr configured in the shipped image.
- `feature-docs-handouts`: documentation (handout, shortcut list) shipped and symlinked into user home directories.
- `acceptance-testing`: automated behave/dogtail harness running headless inside a provisioned live-image VM, tmt integration, and the honest current automation coverage.
- `live-image-build`: kickstart composition via ksflatten, livemedia-creator invocation, Fedora rebase checklist, and manual release practice.

### Modified Capabilities

None - `openspec/specs/` is empty; this is the initial capture.

## Impact

- New: `openspec/specs/*` (created by archiving this change).
- Unchanged: all kickstart files, packages, tests, and scripts. Specs describe today's behavior only.

## Needs resolution (found during capture, intentionally not encoded as requirements)

1. `downloads/mimeapps.list` associates only `audio/flac` to VLC, while Readme claims "audio files open in VLC". Owner to decide intended scope.
2. Readme's Docker build section is stale: example output says `vojtux_38.iso`; no podman support exists anywhere despite it being expected - and plain `docker` is absent on stock Fedora.
3. `ks/vojtux_cs.ks` is outdated and unmaintained (update or delete).
4. `tests/features/steps/steps.py`: `Execute "{command}" command` step calls `os.system` without importing `os` (NameError when used).
5. `tests/features/steps/steps.py`: `hold_key`/`release_key` reference undefined `KEY_PRESS`/`KEY_RELEASE`.
6. `dockerbuild/build.sh` uses `[ ... == ... ]` under `#!/bin/sh` (non-POSIX).
7. `tests/features/environment.py` embeds tracebacks with mime type `"text"` instead of `"text/plain"`.
8. Release asset naming drifts from build output: `vojtux_43.iso` (build) vs `vojtux_43_0.iso` (release).
9. `TESTING.md` says "I do not have any automation" although a behave/dogtail harness exists; only TC11 is wired in `tests/main.fmf`.
10. Readme checksum instruction uses `sha256 -c`; the Fedora command is `sha256sum -c`.
11. Readme claims "QT accessibility is enabled" - no implementation found anywhere in the repository.
12. Readme claims "Grub tune is added" - no grub-tune package or configuration found in the repository.
13. Readme claims "/etc/systemd/system.conf is modified to speed up shutdown" - no such modification found.
14. `vojtux-settings/01-accessibility` sets sound theme `freedesktop` while `a11y-sound-theme`'s `12-a11y` sets `linux-a11y` in the same dconf database; the later key file wins, but the contradiction is confusing.
15. Test id drift: tmt test `/TC1` in `tests/main.fmf` executes behave tag `TC11`.
16. Live medium has no guaranteed unmute path: the "unmute master to 50%" step exists only in `orca-login-wrapper`, which runs as the LightDM greeter reader. It is unverified whether LightDM's autologin path invokes the greeter (and therefore the reader) before auto-logging the live user; if it does not, live-image speech (TC1) depends on the hardware's default volume and may be silent on muted hardware. Confirm the autologin behavior and, if the hook never runs on the live medium, add a session-level unmute.
