
Feature: Localized texts
  In order to foreigners can understand the page too
  As a user
  I want to change finnish text to english
  
  Scenario: A user visits the homepage, sees finnish text by default
    Given an event, a runner and his run
    
    When I visit the "home" page
    Then I should see "Testijuoksut"
    And I should not see "Test of maturity"
    
    When I visit the "event" page
    Then I should see "Olosuhteet"
    And I should not see "Circumstances"

    When I visit the "runner's profile" page
    Then I should see "Juoksijat"
    And I should not see "Runner"    

  Scenario: A user can change between languages
    Given an event, a runner and his run
    
    When I visit the "home" page
    Then I should see "Testijuoksut"
    And I should not see "Test of maturity"
    
    When I follow "In English"
    Then I should see "Test of maturity"
    And I should not see "Testijuoksut"
    
    When I visit the "event" page
    Then I should see "Circumstances"
    And I should not see "Olosuhteet"

    When I visit the "runner's profile" page
    Then I should see "Runner"    
    And I should not see "Juoksijat"
    
    When I follow "Suomeksi"
    Then I should see "Juoksijat"
    And I should not see "Runner"

    When I visit the "event" page
    Then I should see "Olosuhteet"
    And I should not see "Circumstances"
