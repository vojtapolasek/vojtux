@search_feature
Feature: Search properties

  Background:
    * Start application "terminal" via "command"
    * Make sure window is focused for wayland testing
    * Make sure Menubar is showing


  @search_dialog_shortcut
  Scenario: Open search dialog - shortcut
    * Key combo: "<Shift><Control>f"
    * Item "Find" "frame" that is at least "-30" from topleft is "visible" in "terminal"


  @search_for_string
  Scenario: Search for string
    * Key combo: "<Super><Up>"
    * Execute in terminal: "seq 50"
    * Type text: "test string"
    * Key combo: "<Ctrl><C>"
    * Execute in terminal: "seq 50"
    * Left click "Search" "menu" in "terminal"
    * Left click "Find" "menu item" in "terminal"
    * Wait 3 seconds before action
    * Type text: "string"
    * Left click "None" "push button" with description "Find next occurrence" in "terminal"
    * Press key: "Esc"
    * Terminal contains string "test string"


  @rhbz1442629
  @search_for_string_match_case
  Scenario: Search for string - match case
    * Key combo: "<Super><Up>"
    * Execute in terminal: "seq 50"
    * Type text: "test String"
    * Key combo: "<Ctrl><C>"
    * Execute in terminal: "seq 50"
    * Type text: "test string"
    * Key combo: "<Ctrl><C>"
    * Execute in terminal: "seq 50"
    * Left click "Search" "menu" in "terminal"
    * Left click "Find" "menu item" in "terminal"
    * Wait 3 seconds before action
    * Type text: "string"
    * Left click "Match case" "check box" in "terminal"
    * Left click "None" "push button" with description "Find next occurrence" in "terminal"
    * Key combo: "<Alt><F4>"
    * Terminal contains string "test string"
    * Terminal does not contain string "test String"


  @search_for_string_entire_word
  Scenario: Search for string - entire word
    * Key combo: "<Super><Up>"
    * Execute in terminal: "seq 50"
    * Type text: "test stringtogether"
    * Key combo: "<Ctrl><C>"
    * Execute in terminal: "seq 50"
    * Type text: "test string apart"
    * Key combo: "<Ctrl><C>"
    * Execute in terminal: "seq 50"
    * Left click "Search" "menu" in "terminal"
    * Left click "Find" "menu item" in "terminal"
    * Wait 3 seconds before action
    * Type text: "string"
    * Left click "Match entire word only" "check box" in "terminal"
    * Left click "None" "push button" with description "Find next occurrence" in "terminal"
    * Key combo: "<Alt><F4>"
    * Terminal contains string "test string apart"
    * Terminal does not contain string "test stringtogether"


  @search_for_string_regex
  Scenario: Search for string - regular expression
    * Key combo: "<Super><Up>"
    * Execute in terminal: "seq 50"
    * Type text: "test String"
    * Key combo: "<Ctrl><C>"
    * Execute in terminal: "seq 50"
    * Type text: "test string"
    * Key combo: "<Ctrl><C>"
    * Execute in terminal: "seq 50"
    * Left click "Search" "menu" in "terminal"
    * Left click "Find" "menu item" in "terminal"
    * Wait 3 seconds before action
    * Type text: "^.*st[rR]ing.*$"
    * Left click "Match case" "check box" in "terminal"
    * Left click "Match as regular expression" "check box" in "terminal"
    * Left click "None" "push button" with description "Find next occurrence" in "terminal"
    * Key combo: "<Alt><F4>"
    * Terminal contains string "test string"
    * Terminal does not contain string "test String"


  @search_backwards
  Scenario: Search backwards
    * Key combo: "<Super><Up>"
    * Execute in terminal: "seq 50"
    * Type text: "test string first"
    * Key combo: "<Ctrl><C>"
    * Execute in terminal: "seq 50"
    * Type text: "test string second"
    * Key combo: "<Ctrl><C>"
    * Execute in terminal: "seq 50"
    * Left click "Search" "menu" in "terminal"
    * Left click "Find" "menu item" in "terminal"
    * Wait 3 seconds before action
    * Type text: "string"
    * Left click "None" "push button" with description "Find previous occurrence" in "terminal"
    * Key combo: "<Alt><F4>"
    * Terminal contains string "test string second"
    * Terminal does not contain string "test string first"


  @search_next_shortcut
  Scenario: Search next - shortcut
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
    * Key combo: "<Shift><Control><G>"
    * Terminal does not contain string "test string first"
    * Terminal contains string "test string second"
    * Terminal does not contain string "test string third"


  @search_previous_shortcut
  Scenario: Search previous - shortcut
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
    * Key combo: "<Shift><Control><H>"
    * Terminal does not contain string "test string first"
    * Terminal does not contain string "test string second"
    * Terminal contains string "test string third"
