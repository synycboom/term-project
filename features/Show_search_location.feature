Feature: Show search result(location)
  As an admin
  So that I can see the result searching of location
  I want to see the searching lists
  
Scenario: Show search result location
   Given the following locations exist:
  | room_no | total_table   | building    |
  | 418     | 23            | Engineering |
  | 315     | 20            | Engineering |
  | 304     | 15            |  SC         |
  And  I am on the home page
  
  Given I follow "Go to show all locations"
  Then I select "Room Number" from "search_by"
  And I fill in "search_value" with "418"
  Then I press "Search"
  And I should see "418"
  And I should see "23"
  And I should see "Engineering"
  
Scenario: Show search result location(sad path)
  Given the following locations exist:
  | room_no | total_table   | building    |
  | 418     | 23            | Engineering |
  | 315     | 20            | Engineering |
  | 304     | 15            |  SC         |
  And  I am on the home page
  Given I follow "Go to show all locations"
  Then I select "Building" from "search_by"
  And I fill in "search_value" with "LC"
  Then I press "Search"
  And I should see "No Data!!!"
  
  