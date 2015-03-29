Feature: Add a new location

  As an Administrator
  so that I can use a new location
  I want to add a new location to the system

Scenario: Add a new location
  Given I am on the home page
  And I follow "Go to show all locations"
  Then I follow "add new location"
  When I fill in the following:
     | location[room_no]  | 502   |
     | location[building]     | sc    |
     | location[total_table]  | 60    |
  And I press "Save Location"
  Then I should see "502 was successfully created."

Scenario: If i didn't full filling the form field i can't add a new location(sad path)
  Given I am on the home page
  And I follow "Go to show all locations"
  Then I follow "add new location"
  And I press "Save Location"
  Then I should see "Total table: can't be blank"
  
Scenario: Total table field must be number(validate)
  Given I am on the home page
  And I follow "Go to show all locations"
  Then I follow "add new location"
  When I fill in the following:
     | location[room_no]      | 502   |
     | location[building]     | sc    |
     | location[total_table]  | abc    |
  And I press "Save Location"
  Then I should see "Total table: is not a number" 