Feature: Show the schedule

  As an admin
  So that I can see the schedule
  I want to show all schedule
  
Background: schedule in database

  Given the following schedule exist:
  | s_id  |     room_no        | s_name            | date      |     time    |
  | cn202 |     418            | Data structure 1  | 1/Jan/2558|    14:00    |
  And  I am on the home page
  
Scenario: Show all schedule
  Given I follow "Go to show all locations"
  Then I should see "cn202"
  And I should see "418"
  And I should see "Data structure 1"
  And I should see "1/Jan/2558"
  And I should see "14:00"
  
Scenario: Show all schedule(sad path)
  Given I follow "Go to show all locations"
  Then I should not see "cn202"
  And I should not see "418"
  And I should not see "Data structure 1"
  And I should not see "1/Jan/2558"
  And I should not see "14:00"