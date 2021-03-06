Feature: Show all available locations

  As an Administrator
  so that I can see available locations
  I want to show all available locations in the system


Scenario: Show all available locations
  Given the following locations exist:
  | room_no | total_table   | building    |
  | 418     | 23            | Engineering |
  And  I am on the home page
  Given I follow "Go to show all locations"
  Then I should see "418"
  And I should see "23"
  And I should see "Engineering"
  
Scenario: Show all available locations(sad path)
  Given I am on the home page
  And I follow "Go to show all locations"
  Then I should not see "418"
  And I should not see "23"
  And I should not see "Engineering"