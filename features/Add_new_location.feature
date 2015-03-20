Feature: Add a new location

  As an Administrator
  so that I can use a new location
  I want to add a new location to the system

Scenario: Add a new location
  Given I am on the home page
  And I follow "Go to show all locations"
  Then I follow "add new location"
  When I fill in the following:
     | Room number      | 502   |
     | Building     | sc    |
     | Total Table  | 60    |
  And I press "Save Changes"
  Then I should see "502 was successfully created."

