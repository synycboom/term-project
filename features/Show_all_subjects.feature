Feature: Show all subjects

  As an Administrator
  so that I can see all subjects
  I want to show all subjects

Background: subjects in database

  Given the following subjects exist:
  | s_id  |     s_name        | section | date      |     time    |
  | cn202 | Data structure 1  | 680002  | 1/Jan/2558|    14:00    |
  And  I am on the home page

Scenario: Show all available locations
  Given I follow "Go to show all subjects"
  Then I should see "cn202"
  And I should see "Data structure 1"
  And I should see "680002"
  And I should see "14:00"
  And I should see "1/Jan/2558"

Scenario: Show all available locations
  Given I follow "Go to show all subjects"
  Then I should not see "cn202"
  And I should not see "Data structure 1"
  And I should not see "680002"
  And I should not see "14:00"
  And I should not see "1/Jan/2558"