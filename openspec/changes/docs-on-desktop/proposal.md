# Move documentation to a more prominent place

## Why

Issue #104: the Vojtux documentation is reachable only through the `~/documentation` symlink, which new users do not discover (see also #111, where a new user reported never having seen any user documentation). The desktop is the first place a new user lands after login, so the documentation should be visible there.

## What Changes

- `ks/vojtux_en.ks` `%post` additionally creates `Desktop/documentation` symlinks to `/usr/share/doc/vojtux-docs-en` for the live user (`/home/liveuser/Desktop/`) and for newly created users (`/etc/skel/Desktop/`). The existing `~/documentation` symlinks stay unchanged.

## Capabilities

### New Capabilities

None.

### Modified Capabilities

- `feature-docs-handouts`: documentation is reachable from the desktop as well as from the home directory.

## Impact

- Modified: `ks/vojtux_en.ks`.
- New: this change folder; on archive, the modified requirement merges into `openspec/specs/feature-docs-handouts/spec.md`.
- No package changes; the `vojtux-docs-en` RPM is untouched.
