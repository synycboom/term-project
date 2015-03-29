Feature: Show all details(location)
  As an admin
  So that I can see the details of location managed room and subject
  I want to see the details
  
  
Scenario: Show location details
    Given the following locations exist:
  | room_no | total_table   | building    |
  | 418     | 23            | Engineering |
  And  I am on the home page
  Given I follow "Go to show all locations"
  Then I follow "Details"
  And I should see "Room: 418"
  And I should see "Building: Engineering"
  And I should see "Total_table: 23"
  
