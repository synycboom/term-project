Feature: Show all available locations

  As an Administrator
  so that I can see available locations
  I want to show all available locations in the system

Background: locations in database

  Given the following locations exist:
  | room_no | total_table   | building    |
  | 418     | 23            | Engineering |

  
  And  I am on the home page

Scenario: Show all available locations
  Given I follow "Go to show all locations"
  Then I should see "418"
  And I should see "23"
  And I should see "Engineering"