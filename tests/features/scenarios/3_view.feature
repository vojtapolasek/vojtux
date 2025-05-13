@view_feature
Feature: View properties

  Background:
    * Start application "terminal" via "command"
    * Make sure window is focused for wayland testing
    * Make sure Menubar is showing


  @zoom_in_shortcut
  Scenario: Zooming In - shortcut
    * Store terminal size
    * Key combo: "<Ctrl><Shift><plus>"
    * Terminal window is now "bigger"


  @zoom_out_shortcut
  Scenario: Zooming Out - shortcut
    * Store terminal size
    * Key combo: "<Ctrl><minus>"
    * Terminal window is now "smaller"


  @zoom_in_normal_shortcut
  Scenario: Normal size after zoom in - shortcut
    * Store terminal size
    * Left click "View" "menu" in "terminal"
    * Left click "Zoom In" "menu item" in "terminal"
    * Key combo: "<Ctrl><0>"
    * Terminal window is now "back to original"


  @zoom_out_normal_shortcut
  Scenario: Normal size after zoom out - shortcut
    * Store terminal size
    * Left click "View" "menu" in "terminal"
    * Left click "Zoom Out" "menu item" in "terminal"
    * Key combo: "<Control><0>"
    * Terminal window is now "back to original"


  @rhbz1665859
  @predefined_size_80_24
  Scenario: Terminal size from predefined - 80x24
    * Store terminal size
    * Left click "Terminal" "menu" in "terminal"
    * Left click "1. 80" "menu item" in "terminal"
    * Terminal window is now "back to original"
    * Left click "Terminal" "menu" in "terminal"
    * Left click "2. 80" "menu item" in "terminal"
    * Terminal window is now "bigger"
    * Left click "Terminal" "menu" in "terminal"
    * Left click "3. 132" "menu item" in "terminal"
    * Terminal window is now "bigger"
    * Left click "Terminal" "menu" in "terminal"
    * Left click "4. 132" "menu item" in "terminal"
    * Terminal window is now "bigger"


  @rhbz1665859
  @predefined_size_80_43
  Scenario: Terminal size from predefined - 80x43
    * Open preferences
    * Set terminal size to columns: "80" and rows: "43"
    * Key combo: "<Shift><Ctrl><Q>"
    * Start application "terminal" via "command"
    * Wait 2 seconds before action
    * Store terminal size
    * Make sure Menubar is showing
    * Left click "Terminal" "menu" in "terminal"
    * Left click "1. 80" "menu item" in "terminal"
    * Terminal window is now "smaller"
    * Left click "Terminal" "menu" in "terminal"
    * Left click "2. 80" "menu item" in "terminal"
    * Terminal window is now "back to original"
    * Left click "Terminal" "menu" in "terminal"
    * Left click "3. 132" "menu item" in "terminal"
    * Terminal window is now "bigger"
    * Left click "Terminal" "menu" in "terminal"
    * Left click "4. 132" "menu item" in "terminal"
    * Terminal window is now "bigger"


  @predefined_size_132_24
  Scenario: Terminal size from predefined - 132x24
    * Open preferences
    * Set terminal size to columns: "132" and rows: "24"
    * Key combo: "<Shift><Ctrl><Q>"
    * Start application "terminal" via "command"
    * Store terminal size
    * Make sure Menubar is showing
    * Left click "Terminal" "menu" in "terminal"
    * Left click "1. 80" "menu item" in "terminal"
    * Terminal window is now "smaller"
    * Left click "Terminal" "menu" in "terminal"
    * Left click "2. 80" "menu item" in "terminal"
    * Terminal window is now "smaller"
    * Left click "Terminal" "menu" in "terminal"
    * Left click "3. 132" "menu item" in "terminal"
    * Terminal window is now "back to original"
    * Left click "Terminal" "menu" in "terminal"
    * Left click "4. 132" "menu item" in "terminal"
    * Terminal window is now "bigger"


  @predefined_size_132_43
  Scenario: Terminal size from predefined - 132x43
    * Open preferences
    * Set terminal size to columns: "132" and rows: "43"
    * Key combo: "<Shift><Ctrl><Q>"
    * Start application "terminal" via "command"
    * Store terminal size
    * Make sure Menubar is showing
    * Left click "Terminal" "menu" in "terminal"
    * Left click "1. 80" "menu item" in "terminal"
    * Terminal window is now "smaller or not changed"
    * Left click "Terminal" "menu" in "terminal"
    * Left click "2. 80" "menu item" in "terminal"
    * Terminal window is now "smaller or not changed"
    * Left click "Terminal" "menu" in "terminal"
    * Left click "3. 132" "menu item" in "terminal"
    * Terminal window is now "smaller or not changed"
    * Left click "Terminal" "menu" in "terminal"
    * Left click "4. 132" "menu item" in "terminal"
    * Terminal window is now "back to original"
