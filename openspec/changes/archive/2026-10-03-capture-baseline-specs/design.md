# Design: capture-baseline-specs

## Context

`openspec/specs/` is empty; the repo predates OpenSpec. This change is a **brownfield baseline capture**, decided jointly with the maintainer through a structured interview. No source code is modified.

## Goals / Non-Goals

**Goals:**
- Encode today's *actual* behavior as reviewable, testable requirements.
- Establish capability taxonomy and authoring conventions for all future changes.
- Surface every doc-vs-code divergence instead of laundering it into "correct" specs.

**Non-Goals:**
- Specifying Readme aspirations or fixing any of the captured defects.
- Documenting inherited Fedora internals beyond what Vojtux depends on.
- Importing `TESTING.md` test steps into specs (single source of truth stays in TESTING.md).

## Decisions

### Decision 1: One spec per feature, `feature-*` prefix
Each user-visible feature gets its own capability; `acceptance-testing` and `live-image-build` are the two infrastructure capabilities. Rationale: a feature is simultaneously the unit of change, the unit of test, and (per the package-first principle) the target unit of packaging. The `feature-` prefix keeps features visually separate from infrastructure in listings. Retiring a feature later (the "NO VOJTUX NEEDED" endgame) removes one folder cleanly.

### Decision 2: Current reality over documentation
Where Readme and code disagree, specs state the code's behavior (e.g. FLAC-only association, SELinux *disabled*, no grub-tune/QT-a11y/fast-shutdown at all) and the divergence is listed in the proposal's Needs-resolution section. Unobservable broken code (e.g. NameError in an unused step) never becomes a requirement.

### Decision 3: Vehicle pointers, vehicle-free requirements
Requirements state behavior without depending on delivery mechanism; each carries a "Delivered by ..." pointer (package or kickstart section) that survives the ongoing kickstart→RPM migration with a one-line edit. Scenarios carry "Verified by: TCnn | none" notes cross-referencing TESTING.md / automation.

### Decision 4: Capture via change + archive
Using the official pipeline (`## ADDED Requirements` deltas merged by `openspec archive`) rather than hand-writing canonical specs, so the archive preserves the capture date and rationale as decision history.
