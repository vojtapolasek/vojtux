@general_feature
Feature: General Tests


  @start_firefox_with_shortcut
  @TC11
  Scenario: Start Firefox via special shortcut
    * Press "<Alt><Win>F"
    Then "Firefox" application should start
    Then "firefox" process is running

