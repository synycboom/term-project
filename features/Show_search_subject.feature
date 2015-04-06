Feature: Show search result(subject)
  As an admin
  So that I can see the result searching of subject
  I want to see the searching lists
  
Scenario: Show search result subject
   Given the following subjects exist:
  | s_id  |     s_name        | section | date      |     time    |
  | cn202 | Data structure 1  | 680002  | 1/Jan/2558|    14:00    |
  | cn201 | OOP               | 570001  | 1/Jan/2558|     12:00   |
  | cn418 | Web Application Security  | 340001  | 3/Jan/2558 | 11:00 |
  
  And  I am on the home page
  Given I follow "Go to show all subjects"
  Then I select "Subject Name" from "search_by"
  And I fill in "search_value" with "Data structure 1"
  Then I press "Search"
  And I should see "Data structure 1"
  And I should see "cn202"
  And I should see "680002"
  And I should see "1/Jan/2558"
  And I should see "14:00"
  
Scenario: Show search result subject(sad path)
  Given the following subjects exist:
  | s_id  |     s_name        | section | date      |     time    |
  | cn202 | Data structure 1  | 680002  | 1/Jan/2558|    14:00    |
  | cn201 | OOP               | 570001  | 1/Jan/2558|     12:00   |
  | cn418 | Web Application Security  | 340001  | 3/Jan/2558 | 11:00 |
  
  And  I am on the home page
  Then I follow "Go to show all subjects"
  And I select "Subject Name" from "search_by"
  And I fill in "search_value" with "asdasd"
  Then I press "Search"
  And I should see "No Data!!!"
  