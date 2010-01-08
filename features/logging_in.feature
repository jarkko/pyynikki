Feature: Logging in
  In order to be able to administer stuff
  As an admin
  I want to be able to authenticate myself

  Scenario: Successful login
    Given existing user
    When I go to admin page
    And I fill in "Email" with "jarkko@jlaine.net"
    And I fill in "Password" with "tiger"
    And I press "Log In"
    Then I should be on admin page
    
  Scenario: Failed login
    Given existing user
    When I go to admin page
    And I fill in "Email" with "jarkko@jlaine.net"
    And I fill in "Password" with "leopard"
    And I press "Log In"
    Then I should be on the login page
    And I should see "Login failed"