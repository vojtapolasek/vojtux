# Add missing specification for Caja sound preview behavior

## Why

The `capture-baseline-specs` change listed `feature-disable-caja-previews` as a capability but its delta spec file was accidentally omitted, so the archived baseline is missing one approved capability. This change adds it.

## What Changes

- Add the `feature-disable-caja-previews` capability with one requirement describing current behavior.

## Capabilities

### New Capabilities

- `feature-disable-caja-previews`: Caja sound previews are disabled so that moving through files never plays audio unexpectedly.

### Modified Capabilities

None.

## Impact

- New: `openspec/specs/feature-disable-caja-previews/spec.md`.
- No code changes.
