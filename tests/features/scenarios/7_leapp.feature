@leapp_feature
Feature: Leapp feature

  Background:
    * Start application "terminal" via "command"
    * Make sure window is focused for wayland testing
    * Make sure Menubar is showing


  @leapp
  @create_profile_for_leapp
  Scenario: Create new profile for gnome-terminal-server
    * Create profile named "myprofile"


  @leapp
  @profile_for_leapp_exists
  Scenario: Verify new profile for gnome-terminal-server exists
    * Profile named "myprofile" exists
