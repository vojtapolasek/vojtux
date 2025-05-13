@profiles_feature
Feature: Profiles feature

  Background:
    * Start application "terminal" via "command"
    * Make sure window is focused for wayland testing
    * Make sure Menubar is showing


  @create_profile
  Scenario: Create new profile for gnome-terminal-server
    * Create profile named "myprofile"
    * Profile named "myprofile" exists


  @delete_profile
  Scenario: Create and then delete profile for gnome-terminal-server
    * Create profile named "myprofile"
    * Delete profile named "myprofile"
    * Profile named "myprofile" does not exist


  @edit_profile
  Scenario: Edit profile for gnome-terminal-server
    * Create profile named "myprofile"
    * Open preferences
    * Item "myprofile" "label" is "showing" in "preferences"


  @change_profile
  Scenario: Change profile
    * Create profile named "myprofile"
    * Wait 2 seconds before action
    * Left click "Terminal" "menu" in "terminal"
    * Expand Change profile menu
    * Left click "myprofile" "radio menu item" in "terminal"
    * Left click "Terminal" "menu" in "terminal"
    * Expand Change profile menu
    * Item "myprofile" "radio menu item" is "checked" in "terminal"


  @change_profile_name
  Scenario: Change profile name
    * Create profile named "myprofile"
    * Open preferences
    * Left click "myprofile" "label" in "preferences"
    * Open toggle menu of profile: "myprofile"
    * Left click "Rename" "push button" in "preferences"
    * Type text: "personal_profile"
    * Left click "Rename" "push button" in "preferences"
    * Close preferences
    * Profile named "myprofile" does not exist
    * Profile named "personal_profile" exists
    * Profile named "myprofile" is not showing
    * Profile named "personal_profile" is showing


  @starting_profile
  Scenario: Set profile to be started as default
    * Create profile named "myprofile"
    * Open preferences
    * Left click "myprofile" "label" in "preferences"
    * Open toggle menu of profile: "myprofile"
    * Left click "Set as default" "push button" in "preferences"
    * Close preferences
    * Start application "terminal" via "command"
    * Wait 2 seconds before action
    * Make sure Menubar is showing
    * Profile named "myprofile" is selected as default


  @profile_cursor_shape
  Scenario: Profile editing - General - Cursor shape
    * Open preferences
    * Set cursor to "Underline"
    * Open preferences
    * Item "Underline" "combo box" is "showing" in "preferences"
    * Set cursor to "I-Beam"
    * Open preferences
    * Item "I-Beam" "combo box" is "showing" in "preferences"
    * Set cursor to "Block"
    * Open preferences
    * Item "Block" "combo box" is "showing" in "preferences"


  @profile_initial_terminal_size
  Scenario: Profile editing - General - Initial terminal size
    * Open preferences
    * Reset settings
    * Open preferences
    * Terminal size is set as columns: "80" and rows: "24"
    * Store terminal size
    * Open preferences
    * Set terminal size to columns: "60" and rows: "30"
    * Start application "terminal" via "command"
    * Wait 2 seconds before action
    * Terminal window is now "smaller"
    * Make sure Menubar is showing
    * Open preferences
    * Reset settings
    * Start application "terminal" via "command"
    * Wait 2 seconds before action
    * Terminal window is now "back to original"


  @profile_command_exit
  Scenario: Profile editing - Custom command - exit
    * Open preferences
    * Left click on "Command" page tab and make sure the tab was selected
    * Left click "Run a custom command instead of my shell" "check box" in "preferences"
    * Press key: "Tab"
    * Type text: "gedit"
    * Set "When command exits:" to "Exit the terminal" under: "Command"
    * Close preferences
    * Key combo: "<Control><Shift><N>"
    * Wait 1 second before action
    * Terminal has "2" windows
    * Application "gedit" is running
    * Close application "gedit" via "gnome panel with workaround"
    * Terminal has "1" windows
    * Application "gedit" is no longer running


  @profile_command_rerun
  Scenario: Profile editing - Custom command - rerun
    * Open preferences
    * Left click on "Command" page tab and make sure the tab was selected
    * Left click "Run a custom command instead of my shell" "check box" in "preferences"
    * Press key: "Tab"
    * Type text: "gedit"
    * Set "When command exits:" to "Restart the command" under: "Command"
    * Close preferences
    * Key combo: "<Control><Shift><N>"
    * Terminal has "2" windows
    * Application "gedit" is running
    * Close application "gedit" via "gnome panel with workaround"
    * Terminal has "2" windows
    * Application "gedit" is running
    * Close application "gedit" via "gnome panel with workaround"
    * Terminal has "2" windows
    * Application "gedit" is running


  @profile_command_keep_open
  Scenario: Profile editing - Custom command - keep open
    * Open preferences
    * Left click on "Command" page tab and make sure the tab was selected
    * Left click "Run a custom command instead of my shell" "check box" in "preferences"
    * Press key: "Tab"
    * Type text: "gedit"
    * Set "When command exits:" to "Hold the terminal open" under: "Command"
    * Close preferences
    * Key combo: "<Control><Shift><N>"
    * Terminal has "2" windows
    * Application "gedit" is running
    * Close application "gedit" via "gnome panel with workaround"
    * Terminal has "2" windows
    * Application "gedit" is no longer running


  @profile_default_color
  Scenario Outline: Profile editing - Colors - default <column> color
    * Open preferences
    * Left click on "Colors" page tab and make sure the tab was selected
    * Left click "Use colors from system theme" "check box" in "preferences"
    * Set "Built-in schemes:" to "White on black" under: "Text and Background Color"
    * The profile option: "<color_option>" is not set to "<color_rgb_value>" in dconf
    * Select option in row: "Default color:" and column: "<column>"
    * Set color name to: "<color_hex_value>"
    * Left click "Select" "push button" in "preferences"
    * The profile option: "<color_option>" is set to "<color_rgb_value>" in dconf
    Examples:
      | color_option     | column     | color_rgb_value  | color_hex_value |
      | foreground-color | Text       | rgb(114,159,207) | #729fcf         |
      | background-color | Background | rgb(204,0,0)     | #cc0000         |


  @profile_colors
  Scenario Outline: Profile editing - Colors - <row> <column> color
    * Open preferences
    * Left click on "Colors" page tab and make sure the tab was selected
    * Left click "Use colors from system theme" "check box" in "preferences"
    * Set "Built-in schemes:" to "White on black" under: "Text and Background Color"
    * The profile option: "<color_option>" is not set to "<color_rgb_value>" in dconf
    * The profile option: "<enable_option>" is not set to "<enable_value>" in dconf
    * Left click "<row>" "check box" in "preferences"
    * The profile option: "<enable_option>" is set to "<enable_value>" in dconf
    * Select option in row: "<row>" and column: "<column>"
    * Set color name to: "<color_hex_value>"
    * Left click "Select" "push button" in "preferences"
    * The profile option: "<color_option>" is set to "<color_rgb_value>" in dconf
    Examples:
      | row              | column     | enable_option         | enable_value | color_option               | color_rgb_value | color_hex_value |
      | Bold color:      | Text       | bold-color-same-as-fg | false        | bold-color                 | rgb(204,0,0)    | #cc0000         |
      | Cursor color:    | Text       | cursor-colors-set     | true         | cursor-foreground-color    | rgb(204,0,0)    | #cc0000         |
      | Cursor color:    | Background | cursor-colors-set     | true         | cursor-background-color    | rgb(204,0,0)    | #cc0000         |
      | Highlight color: | Text       | highlight-colors-set  | true         | highlight-foreground-color | rgb(204,0,0)    | #cc0000         |
      | Highlight color: | Background | highlight-colors-set  | true         | highlight-background-color | rgb(204,0,0)    | #cc0000         |


  @profile_colors_palette
  Scenario: Profile editing - Colors - palette
    * Open preferences
    * Left click on "Colors" page tab and make sure the tab was selected
    * Set "Built-in schemes:" to "Rxvt" under: "Palette"
    * The profile option: "palette" is set to "['rgb(0,0,0)', 'rgb(205,0,0)', 'rgb(0,205,0)', 'rgb(205,205,0)', 'rgb(0,0,205)', 'rgb(205,0,205)', 'rgb(0,205,205)', 'rgb(250,235,215)', 'rgb(64,64,64)', 'rgb(255,0,0)', 'rgb(0,255,0)', 'rgb(255,255,0)', 'rgb(0,0,255)', 'rgb(255,0,255)', 'rgb(0,255,255)', 'rgb(255,255,255)']" in dconf


  @profile_scrolling_size
  Scenario: Profile editing - Scrolling - Scrollback limit
    * Open preferences
    * Left click on "Scrolling" page tab and make sure the tab was selected
    * Set spin button to: "30"
    * Close preferences
    * Execute in terminal: "test string"
    * Execute in terminal: "seq 28"
    * Key combo: "<Shift><Home>"
    * Terminal does not contain string "test string"
    * Terminal contains string "seq 28"
    * The profile option: "scrollback-lines" is set to "30" in dconf
    * Open preferences
    * Left click on "Scrolling" page tab and make sure the tab was selected
    * Set spin button to: "31"
    * Close preferences
    * Execute in terminal: "test string"
    * Execute in terminal: "seq 28"
    * Key combo: "<Shift><Home>"
    * Terminal contains string "test string"
    * Terminal contains string "seq 28"


  @profile_scrolling_keystroke_off
  Scenario: Profile editing - Scrolling - Keystroke Off
    * Open preferences
    * Left click on "Scrolling" page tab and make sure the tab was selected
    * Left click "Scroll on keystroke" "check box" in "preferences"
    * Close preferences
    * Execute in terminal: "seq 50"
    * Key combo: "<Shift><Home>"
    * Type text: "test string"
    * Terminal does not contain string "test string"


  @profile_scrolling_keystroke_on
  Scenario: Profile editing - Scrolling - Keystroke On
    * Open preferences
    * Left click on "Scrolling" page tab and make sure the tab was selected
    * Close preferences
    * Execute in terminal: "seq 30"
    * Key combo: "<Shift><Home>"
    * Type text: "test string"
    * Terminal contains string "test string"


  @profile_scrolling_scroll_on_output_off
  Scenario: Profile editing - Scrolling - Scroll on output off
    * Open preferences
    * Left click on "Scrolling" page tab and make sure the tab was selected
    * Left click "Scroll on keystroke" "check box" in "preferences"
    * Close preferences
    * Execute in terminal: "seq 50"
    * Type text: "test string"
    * Key combo: "<Shift><Home>"
    * Press key: "Return"
    * Terminal does not contain string "test string"
    * Key combo: "<Shift><End>"
    * Terminal contains string "test string"


  @profile_scrolling_scroll_on_output_on
  Scenario: Profile editing - Scrolling - Scroll on output on
    * Open preferences
    * Left click on "Scrolling" page tab and make sure the tab was selected
    * Left click "Scroll on output" "check box" in "preferences"
    * Left click "Scroll on keystroke" "check box" in "preferences"
    * Close preferences
    * Execute in terminal: "seq 50"
    * Type text: "echo test string"
    * Key combo: "<Shift><Home>"
    * Press key: "Return"
    * Terminal contains string "test string"


  @profile_scrolling_unlimited
  Scenario: Profile editing - Scrolling - Unlimited scrolling
    * Open preferences
    * Left click on "Scrolling" page tab and make sure the tab was selected
    * Set spin button to: "30"
    * Left click "Limit scrollback to:" "check box" in "preferences"
    * Close preferences
    * Execute in terminal: "test string"
    * Execute in terminal: "seq 1000"
    * Key combo: "<Shift><Home>"
    * Terminal contains string "test string"
    * The profile option: "scrollback-lines" is set to "30" in dconf
    * The profile option: "scrollback-unlimited" is set to "true" in dconf
