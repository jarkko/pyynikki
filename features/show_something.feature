
Feature: Display something
  In order to know my friends' latest results
  As a user
  I want to have something shown to me
  
  Scenario: User visits the homepage
    Given I have an event at "24.11.2007" in the database
    #And I have a runner at that event, called "Joe Pikkala"
    #And I have his run with time "20:00"
    When I visit the home page (=index page)
    Then I should see "24.11.2007"
    #And I should see "Joe Pikkala"
    #And I should see "20:00"

