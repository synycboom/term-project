Feature: Show all subjects

  As an Administrator
  so that I can see all subjects
  I want to show all subjects


Scenario: Show all available locations
  Given the following subjects exist:
  | s_id  |     s_name        | section | duration      | 
  | cn202 | Data structure 1  | 680002  | 2   |
  And  I am on the home page
  Given I follow "Go to show all subjects"
  Then I should see "cn202"
  And I should see "Data structure 1"
  And I should see "680002"
  And I should see "2"

Scenario: Show all available locations(sad path)
  Given I am on the home page
  And I follow "Go to show all subjects"
  Then I should not see "cn202"
  And I should not see "Data structure 1"
  And I should not see "680002"
  And I should not see "2"