Feature: Show all details(subject)
  As an admin
  So that I can see the details of location managed room and subject
  I want to see the details
  
Scenario: Show subject details
  Given the following subjects exist:
  | s_id  |     s_name        | section | date      |     time    |
  | cn202 | Data structure 1  | 680002  | 1/Jan/2558|    14:00    |
  And  I am on the home page
  Given I follow "Go to show all subjects"
  Then I follow "Details"
  And I should see "Subject: Data structure 1"
  And I should see "ID: cn202"
  And I should see "Section: 680002"
  And I should see "Date: 1/Jan/2558"
  And I should see "Time: 14:00"
  