Feature: Add a new subject
  As an admin
  So that I can use a new subject
  I want to add a new subject to the system
  
Scenario: Add a new subject
  Given I am on the home page
  And I follow "Go to show all subjects"
  Then I follow "add new subject"
  When I fill in the following:
     | subject[s_id]  | cn201   |
     | subject[s_name]     | sc    |
     | subject[section]  | 60    |
  And I press "Save Subject"
  Then I should see "cn201 was successfully created."
  
Scenario: If i didn't full filling the form field i can't add a new subject(sad path)
  Given I am on the home page
  And I follow "Go to show all subjects"
  Then I follow "add new subject"
  And I press "Save Subject"
  Then I should see "Subject id: can't be blank"
  And I should see "Subject name: can't be blank"
  And I should see "Section: can't be blank"