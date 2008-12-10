
Feature: Localize texts
  In order to foreigners can understand the page too
  As a user
  I want to see localized text 
  
  Scenario: Finn user visits the homepage, sees finnish text
    Given I'm a "finn" user
    And I have an event, a runner and his run
    
    When I visit the "home" page
    Then I should see "Testijuoksut"
    And I should not see "Test of maturity"
    
    When I visit the "event" page
    Then I should see "Olosuhteet"
    And I should not see "Circumstances"

    When I visit the "runner's profile" page
    Then I should see "Juoksijat"
    And I should not see "Runner"    

  Scenario: Hungarian user visits the homepage, sees english text
    Given I'm a "hungarian" user
    And I have an event, a runner and his run
    
    When I visit the "home" page
    Then I should see "Test of maturity"
    And I should not see "Testijuoksut"
    
    When I visit the "event" page
    Then I should see "Circumstances"
    And I should not see "Olosuhteet"

    When I visit the "runner's profile" page
    Then I should see "Runner"    
    And I should not see "Juoksijat"
