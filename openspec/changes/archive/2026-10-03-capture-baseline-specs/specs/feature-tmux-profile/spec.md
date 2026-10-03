# feature-tmux-profile

## ADDED Requirements

### Requirement: tmux preconfigured with Byobu-inspired shortcuts
The system SHALL ship tmux with a Vojtux configuration using Byobu-inspired keyboard shortcuts for new users, making console multiplexing usable without reading small status bars. Delivered by `downloads/.tmux.conf` copied to `/etc/skel` in `ks/vojtux_en.ks` `%post`. Verified by: none.

#### Scenario: New user starts tmux
- **WHEN** a newly created user runs `tmux`
- **THEN** the Vojtux tmux configuration is active with the Byobu-inspired key bindings
