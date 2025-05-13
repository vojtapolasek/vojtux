@basic_feature
Feature: Basic Tests

  Background:
    * Start application "terminal" via "command"
    * Make sure window is focused for wayland testing
    * Make sure Menubar is showing


  @execute_command
  Scenario: Execute echo command.
    * Execute in terminal: "echo test string"
    * Terminal contains string "test string"


  @copy_and_paste
  Scenario: Copy and paste from terminal to another terminal.
    * Type text: "test string"
    * Left click "Edit" "menu" in "terminal"
    * Left click "Select All" "menu item" in "terminal"
    * Key combo: "<Shift><Ctrl><C>"
    * Key combo: "<Shift><Ctrl><N>"
    * Wait 1 second before action
    * Key combo: "<Shift><Ctrl><V>"
    * Terminal contains string "test string"


  @right_click_menu
  Scenario: Right click menu: show options.
    * Right click "Terminal" "terminal" in "terminal"
    * Item "New Window" "menu item" is "showing" in "terminal"
    * Item "New Tab" "menu item" is "showing" in "terminal"


  @keyboard_shortcuts
  Scenario: Enable/disable keyboard shortcuts.
    * Key combo: "<Super><Up>"
    * Enable shortcuts
    * Key combo: "<Shift><Ctrl><N>"
    * Terminal has "2" windows
    * Left click "File" "menu" in "terminal"
    * Left click "Close Window" "menu item" in "terminal"
    * Terminal has "1" windows
    * Make sure Menubar is showing
    * Open preferences
    * Left click "Shortcuts" "label" in "preferences"
    * Left click "Enable shortcuts" "check box" in "preferences"
    * Close preferences
    * Key combo: "<Shift><Ctrl><N>"
    * Terminal has "1" windows


  @change_keyboard_shortcuts
  Scenario: Change keyboard shortcuts.
    * Open preferences
    * Left click "Shortcuts" "label" in "preferences"
    * Left click "Shift+Ctrl+N" "table cell" in "preferences"
    * Left click "Shift+Ctrl+N" "table cell" in "preferences"
    * Key combo: "<Shift><Ctrl><P>"
    * Close preferences
    * Terminal has "1" windows
    * Key combo: "<Shift><Ctrl><P>"
    * Terminal has "2" windows


  @clear
  Scenario: Clear command has no unexpected output.
    * Execute in terminal: "seq 20"
    * Execute in terminal: "clear"
    * Key combo: "<Shift><Home>"
    * Terminal does not contain string "[3;J"
    * Terminal does not contain string "clear"
