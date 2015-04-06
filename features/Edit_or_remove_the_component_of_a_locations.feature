Feature: Edit or remove the component of a locations
  As an admin
  So that I can use edit or delete function for locations
  I want to edit a room or delete it out of the system
  
  
Scenario: Show edit page
  Given the following locations exist:
  | room_no | total_table   | building    |
  | 418     | 23            | Engineering |
  And  I am on the home page
  Given I follow "Go to show all locations"
  Then I follow "Details"
  And I follow "Edit"
  Then the "location[building]" field should contain "Engineering"
  And the "location[total_table]" field should contain "23"
  
Scenario: Show edit success
  Given the following locations exist:
  | room_no | total_table   | building    |
  | 418     | 23            | Engineering |
  And  I am on the home page
  Given I follow "Go to show all locations"
  Then I follow "Details"
  And I follow "Edit"
  And I press "Update"
  Then I should see "was successfully updated."
  
Scenario: Show delete success
  Given the following locations exist:
  | room_no | total_table   | building    |
  | 418     | 23            | Engineering |
  And  I am on the home page
  Given I follow "Go to show all locations"
  Then I follow "Details"
  And I follow "Delete"
  Then I should see "deleted."
  
