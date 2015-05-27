Feature: Edit or remove the component of a subjects
  As an admin
  So that I can use edit or delete function for subjects
  I want to edit a room or delete it out of the system
  
Scenario: Show edit page
  Given the following subjects exist:
  | s_id  |     s_name        | section | 
  | cn202 | Data structure 1  | 680002  |     
  And  I am on the home page
  Given I follow "Go to show all subjects"
  Then I follow "Details"
  And I follow "Edit"
  Then the "subject[s_name]" field should contain "Data structure 1"
  And the "subject[section]" field should contain "680002"

  
Scenario: Show edit success
  Given the following subjects exist:
  | s_id  |     s_name        | section | 
  | cn202 | Data structure 1  | 680002  | 
  And  I am on the home page
  Given I follow "Go to show all subjects"
  Then I follow "Details"
  And I follow "Edit"
  And I press "Update"
  Then I should see "was successfully updated."
  
Scenario: Show delete success
  Given the following subjects exist:
  | s_id  |     s_name        | section |  
  | cn202 | Data structure 1  | 680002  | 
  And  I am on the home page
  Given I follow "Go to show all subjects"
  Then I follow "Details"
  And I follow "Delete"
  Then I should see "deleted."