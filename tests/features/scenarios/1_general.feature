@general_feature
Feature: General Tests


  @start_via_command
  Scenario: Start application via command.
    * Start application "firefox" via "command"


  @start_via_menu
  Scenario: Start application via menu.
    * Start application "firefox" via "menu"


  @quit_via_shortcut
  Scenario: Ctrl-Q to quit application.
    * Start application "firefox" via "command"
    * Make sure window is focused for wayland testing
    * Close application "firefox" via "shortcut"

