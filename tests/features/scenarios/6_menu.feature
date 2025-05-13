@terminal_menu_feature
Feature: Terminal Menu Functionality

  Background:
    * Start application "terminal" via "command"
    * Make sure window is focused for wayland testing
    * Make sure Menubar is showing


  @file_menu_new_tab
  Scenario: Make a New Tab
    * Left click "File" "menu" in "terminal"
    * Left click "New Tab" "menu item" in "terminal"
    * Terminal has "2" tabs


  @file_menu_new_window
  Scenario: Make a New Window
    * Left click "File" "menu" in "terminal"
    * Left click "New Window" "menu item" in "terminal"
    * Terminal has "2" windows


  @file_menu_close_tab_with_single_tab_open
  Scenario: Make a Close Tab while having single tab
    * Left click "File" "menu" in "terminal"
    * Left click "Close Tab" "menu item" in "terminal"
    * Application "terminal" is no longer running


  @file_menu_close_tab_with_many_tabs_open
  Scenario: Make a Close Tab while having many tabs
    * Left click "File" "menu" in "terminal"
    * Left click "New Tab" "menu item" in "terminal"
    * Terminal has "2" tabs
    * Left click "File" "menu" in "terminal"
    * Left click "Close Tab" "menu item" in "terminal"
    * Terminal has "1" tabs


  @file_menu_close_window_with_single_window_open
  Scenario: Make a Close Window while having single window
    * Left click "File" "menu" in "terminal"
    * Left click "Close Window" "menu item" in "terminal"
    * Application "terminal" is no longer running


  @file_menu_close_window_with_many_windows_open
  Scenario: Make a Close Window while having many windows
    * Left click "File" "menu" in "terminal"
    * Left click "New Window" "menu item" in "terminal"
    * Terminal has "2" windows
    * Key combo: "<Alt><asciitilde>"
    * Left click "File" "menu" in "terminal"
    * Left click "Close Window" "menu item" in "terminal"
    * Terminal has "1" windows


  @edit_menu_copy
  Scenario: Copy text in Terminal
    * Left click "Edit" "menu" in "terminal"
    * Item "Copy" "menu item" is not "sensitive" in "terminal"
    * Mouse over "Terminal" "menu" in "terminal"
    * Left click "Reset and Clear" "menu item" in "terminal"
    * Type text: "terminal-copy-test"
    * Left click "Edit" "menu" in "terminal"
    * Left click "Select All" "menu item" in "terminal"
    * Left click "Edit" "menu" in "terminal"
    * Item "Copy" "menu item" is "sensitive" in "terminal"
    * Left click "Copy" "menu item" in "terminal"
    * Key combo: "<Ctrl><C>"
    * Left click "Terminal" "menu" in "terminal"
    * Left click "Reset and Clear" "menu item" in "terminal"
    * Key combo: "<Ctrl><Shift><V>"
    * Terminal contains string "terminal-copy-test"


  @edit_menu_copy_as_html
  Scenario: Copy text in Terminal as HTML
    * Left click "Edit" "menu" in "terminal"
    * Item "Copy as HTML" "menu item" is not "sensitive" in "terminal"
    * Mouse over "Terminal" "menu" in "terminal"
    * Left click "Reset and Clear" "menu item" in "terminal"
    * Type text: "copy-as-html-test"
    * Left click "Edit" "menu" in "terminal"
    * Left click "Select All" "menu item" in "terminal"
    * Left click "Edit" "menu" in "terminal"
    * Item "Copy as HTML" "menu item" is "sensitive" in "terminal"
    * Left click "Copy as HTML" "menu item" in "terminal"
    * Key combo: "<Ctrl><C>"
    * Left click "Terminal" "menu" in "terminal"
    * Left click "Reset and Clear" "menu item" in "terminal"
    * Key combo: "<Ctrl><C>"
    * Press key: "Enter"
    * Key combo: "<Ctrl><Shift><V>"
    * Terminal contains string "<pre>"
    * Terminal contains string "copy-as-html-test"
    * Terminal contains string "</pre>"


  @edit_menu_paste
  Scenario: Paste text in Terminal
    * Left click "Terminal" "menu" in "terminal"
    * Left click "Reset and Clear" "menu item" in "terminal"
    * Type text: "terminal-paste-test"
    * Left click "Edit" "menu" in "terminal"
    * Left click "Select All" "menu item" in "terminal"
    * Key combo: "<Ctrl><Shift><C>"
    * Key combo: "<Ctrl><C>"
    * Left click "Terminal" "menu" in "terminal"
    * Left click "Reset and Clear" "menu item" in "terminal"
    * Left click "Edit" "menu" in "terminal"
    * Left click "Paste" "menu item" in "terminal"
    * Terminal contains string "terminal-paste-test"


  @edit_menu_select_all
  Scenario: Select All in Terminal
    * Left click "Edit" "menu" in "terminal"
    * Item "Copy" "menu item" is not "sensitive" in "terminal"
    * Item "Copy as HTML" "menu item" is not "sensitive" in "terminal"
    * Left click "Select All" "menu item" in "terminal"
    * Left click "Edit" "menu" in "terminal"
    * Item "Copy" "menu item" is "sensitive" in "terminal"
    * Item "Copy as HTML" "menu item" is "sensitive" in "terminal"


  @edit_menu_preferences
  Scenario: Open Preferences
    * Left click "Edit" "menu" in "terminal"
    * Left click "Preferences" "menu item" in "terminal"
    * Item "Preferences" "frame" that is at least "-30" from topleft is "showing" in "preferences"


  @view_menu_show_menubar
  Scenario: View Menu Show Menubar
    * Left click "View" "menu" in "terminal"
    * Left click "Show Menubar" "check menu item" in "terminal"
    * Item "File" "menu" is not "showing" in "terminal"
    * Right click "Terminal" "terminal" in "terminal"
    * Left click "Show Menubar" "check menu item" in "terminal"
    * Item "File" "menu" is "showing" in "terminal"


  @view_menu_fullscreen
  Scenario: View Menu Full Screen
    * Left click "View" "menu" in "terminal"
    * Left click "Full Screen" "check menu item" in "terminal"
    * Window is fullscreen
    * Press key: "F11"
    * Window is not fullscreen


  @gbz555668
  @rhbz1352470
  @view_menu_restore_from_fullscreen
  Scenario: View Menu Full Screen - restore
    * Store terminal size
    * Left click "View" "menu" in "terminal"
    * Left click "Full Screen" "check menu item" in "terminal"
    * Press key: "F11"
    * Window is not fullscreen
    * Terminal window is now "back to original"


  @view_menu_zoom_in
  Scenario: View Menu Zoom In
    * Store terminal size
    * Left click "View" "menu" in "terminal"
    * Left click "Zoom In" "menu item" in "terminal"
    * Terminal window is now "bigger"


  @view_menu_normal_size_from_zoom_in
  Scenario: View Menu Normal Size from Zoom In
    * Store terminal size
    * Left click "View" "menu" in "terminal"
    * Left click "Zoom In" "menu item" in "terminal"
    * Left click "View" "menu" in "terminal"
    * Left click "Normal Size" "menu item" in "terminal"
    * Terminal window is now "back to original"


  @view_menu_normal_size_from_zoom_out
  Scenario: View Menu Normal Size from Zoom Out
    * Store terminal size
    * Left click "View" "menu" in "terminal"
    * Left click "Zoom Out" "menu item" in "terminal"
    * Left click "View" "menu" in "terminal"
    * Left click "Normal Size" "menu item" in "terminal"
    * Terminal window is now "back to original"


  @view_menu_zoom_out
  Scenario: View Menu Zoom Out
    * Store terminal size
    * Left click "View" "menu" in "terminal"
    * Left click "Zoom Out" "menu item" in "terminal"
    * Terminal window is now "smaller"


  @search_menu_find
  Scenario: Search Menu Find...
    * Left click "Search" "menu" in "terminal"
    * Left click "Find" "menu item" in "terminal"
    * Wait 3 seconds before action
    * Item "Find" "frame" that is at least "-30" from topleft is "visible" in "terminal"


  @search_menu_find_next
  Scenario: Search Menu Find Next
    * Key combo: "<Super><Up>"
    * Execute in terminal: "seq 50"
    * Type text: "test string first"
    * Key combo: "<Ctrl><C>"
    * Execute in terminal: "seq 50"
    * Type text: "test string second"
    * Key combo: "<Ctrl><C>"
    * Execute in terminal: "seq 50"
    * Type text: "test string third"
    * Key combo: "<Ctrl><C>"
    * Execute in terminal: "seq 50"
    * Left click "Search" "menu" in "terminal"
    * Left click "Find" "menu item" in "terminal"
    * Wait 3 seconds before action
    * Type text: "string"
    * Left click "None" "push button" with description "Find next occurrence" in "terminal"
    * Key combo: "<Alt><F4>"
    * Left click "Search" "menu" in "terminal"
    * Left click "Find Next" "menu item" in "terminal"
    * Terminal does not contain string "test stringr first"
    * Terminal contains string "test string second"
    * Terminal does not contain string "test string third"


  @search_menu_find_previous
  Scenario: Search Menu Find Previous
    * Key combo: "<Super><Up>"
    * Execute in terminal: "seq 50"
    * Type text: "test string first"
    * Key combo: "<Ctrl><C>"
    * Execute in terminal: "seq 50"
    * Type text: "test string second"
    * Key combo: "<Ctrl><C>"
    * Execute in terminal: "seq 50"
    * Type text: "test string third"
    * Key combo: "<Ctrl><C>"
    * Execute in terminal: "seq 50"
    * Left click "Search" "menu" in "terminal"
    * Left click "Find" "menu item" in "terminal"
    * Wait 3 seconds before action
    * Type text: "string"
    * Left click "None" "push button" with description "Find next occurrence" in "terminal"
    * Key combo: "<Alt><F4>"
    * Left click "Search" "menu" in "terminal"
    * Left click "Find Previous" "menu item" in "terminal"
    * Terminal does not contain string "test string first"
    * Terminal does not contain string "test string second"
    * Terminal contains string "test string third"


  @search_menu_clear_hightlight
  Scenario: Search Menu Clear Highlight
    * Type text: "terminal-clear-highlight-test"
    * Left click "Search" "menu" in "terminal"
    * Left click "Find" "menu item" in "terminal"
    * Find "terminal-clear-highlight-test"
    * Key combo: "<Alt><F4>"
    * Left click "Search" "menu" in "terminal"
    * Left click "Clear Highlight" "menu item" in "terminal"
    * Key combo: "<Ctrl><Shift><C>"
    * Press key: "Enter"
    * Left click "Terminal" "menu" in "terminal"
    * Left click "Reset and Clear" "menu item" in "terminal"
    * Key combo: "<Ctrl><Shift><V>"
    * Terminal does not contain string "terminal-clear-highlight-test"


  @terminal_menu_set_title
  Scenario: Terminal Menu Set Title
    * Left click "Terminal" "menu" in "terminal"
    * Left click "Set Title" "menu item" in "terminal"
    * Item "Set Title" "alert" is "showing" in "terminal"
    * Type text: "terminal-title-test"
    * Left click "OK" "push button" in "terminal"
    * Item "terminal-title-test" "frame" is "showing" in "terminal"


  @terminal_menu_read_only
  Scenario: Terminal Menu Read Only
    * Left click "Terminal" "menu" in "terminal"
    * Left click "Read-Only" "check menu item" in "terminal"
    * Type text: "terminal-read-only-test"
    * Terminal does not contain string "terminal-read-only-test"


  @terminal_menu_reset_and_clear
  Scenario: Terminal Menu Read Only Reset and clear
    * Type text: "test string"
    * Left click "Terminal" "menu" in "terminal"
    * Left click "Reset and Clear" "menu item" in "terminal"
    * Terminal output is empty


  @terminal_menu_size_80_24
  Scenario: Terminal size from predefined - 80x24
    * Store terminal size
    * Left click "Terminal" "menu" in "terminal"
    * Left click "1. 80" "menu item" in "terminal"
    * Terminal window is now "back to original"


  @terminal_menu_size_80_43
  Scenario: Terminal size from predefined - 80x24
    * Store terminal size
    * Left click "Terminal" "menu" in "terminal"
    * Left click "2. 80" "menu item" in "terminal"
    * Terminal window is now "bigger"


  @terminal_menu_size_132_24
  Scenario: Terminal size from predefined - 80x24
    * Store terminal size
    * Left click "Terminal" "menu" in "terminal"
    * Left click "3. 132" "menu item" in "terminal"
    * Terminal window is now "bigger"


  @terminal_menu_size_132_43
  Scenario: Terminal size from predefined - 80x24
    * Store terminal size
    * Left click "Terminal" "menu" in "terminal"
    * Left click "4. 132" "menu item" in "terminal"
    * Terminal window is now "bigger"


  @tabs_menu_previous_tab
  Scenario: Tabs Menu Previous Tab
    * Prepare two Tabs for testing
    * Key combo: "<Ctrl><Shift><T>"
    * Key combo: "<Alt><2>"
    * Left click "Tabs" "menu" in "terminal"
    * Left click "Previous Tab" "menu item" in "terminal"
    * Type text: "test-string-1"
    * Press key: "Enter"
    * Tab "tab-1" was targeted and contains string "test-string-1"


  @tabs_menu_next_tab
  Scenario: Tabs Menu Next Tab
    * Prepare two Tabs for testing
    * Key combo: "<Ctrl><Shift><T>"
    * Key combo: "<Alt><1>"
    * Left click "Tabs" "menu" in "terminal"
    * Left click "Next Tab" "menu item" in "terminal"
    * Type text: "test-string-2"
    * Press key: "Enter"
    * Tab "tab-2" was targeted and contains string "test-string-2"


  @tabs_menu_move_tab_left
  Scenario: Tabs Menu Move Tab Left
    * Prepare two Tabs for testing
    * Key combo: "<Ctrl><Shift><T>"
    * Key combo: "<Alt><2>"
    * Left click "Tabs" "menu" in "terminal"
    * Left click "Move Terminal Left" "menu item" in "terminal"
    * Key combo: "<Alt><1>"
    * Type text: "test-string-2"
    * Press key: "Enter"
    * Tab "tab-2" was targeted and contains string "test-string-2"


  @tabs_menu_move_tab_right
  Scenario: Tabs Menu Move Tab Right
    * Prepare two Tabs for testing
    * Key combo: "<Ctrl><Shift><T>"
    * Key combo: "<Alt><1>"
    * Left click "Tabs" "menu" in "terminal"
    * Left click "Move Terminal Right" "menu item" in "terminal"
    * Key combo: "<Alt><2>"
    * Type text: "test-string-1"
    * Press key: "Enter"
    * Tab "tab-1" was targeted and contains string "test-string-1"


  @tabs_menu_detach_tab
  Scenario: Tabs Menu Move Detach Tab.
    * Key combo: "<Ctrl><Shift><T>"
    * Left click "Tabs" "menu" in "terminal"
    * Left click "Detach Terminal" "menu item" in "terminal"
    * Terminal has "2" windows


  @help_menu_contents
  Scenario: Help Menu Contents
    * Enable GTK inspector
    * Left click "Help" "menu" in "terminal"
    * Left click "Contents" "menu item" in "terminal"
    * Wait 3 seconds before action
    * Item "Terminal" "document web" is "showing" in "yelp"


  @help_menu_about
  Scenario: Help Menu About
    * Enable GTK inspector
    * Left click "Help" "menu" in "terminal"
    * Left click "About" "menu item" in "terminal"
    * Item "About GNOME Terminal" "dialog" is "showing" in "terminal"


  @help_menu_inspector
  Scenario: Help Menu Inspector
    * Enable GTK inspector
    * Left click "Help" "menu" in "terminal"
    * Left click "Inspector" "menu item" in "terminal"
    * Item "Objects" "radio button" is "showing" in "terminal"
