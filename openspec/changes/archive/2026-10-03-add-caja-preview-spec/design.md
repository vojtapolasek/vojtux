# Design: add-caja-preview-spec

## Context

Follow-up to the archived `capture-baseline-specs` change, which omitted this capability's delta file by mistake.

## Goals / Non-Goals

**Goals:** restore the missing capability using the standard change pipeline.

**Non-Goals:** any code change or behavior change.

## Decisions

### Decision 1: Same capture conventions
The requirement follows the established baseline conventions: actual current behavior, `Delivered by` pointer, `Verified by: none`. Vehicle naming quirk (`02-panel` contains Caja settings) is noted inside the requirement.
