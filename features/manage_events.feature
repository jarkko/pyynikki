Feature: Manage events @wip
  In order to manage test runs
  As an admin 
  I want to be able to add, edit and remove events

Scenario: Create event
  Given a logged in user
  When I am on the admin page
  And I follow "Add new event"
  And I fill in the following:
    |Weather|Kostea|
    |Temperature|4|
    |Story|Hieno keli ja juoksu|
  And I select "November 27, 2009" as the date
  And I press "Create event"
  Then I should see "+4"
  And I should see "Kostea"
  And I should see "Hieno keli ja juoksu"