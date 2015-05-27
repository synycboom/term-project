Feature: Generate the schedule
  As an admin
  So that I can generating the schedule
  I want to show all schedule
  
Scenario: Generate success(midterm)
  Given the following locations exist:
  | room_no | total_table   | building    |
  | 418     | 23            | Engineering |
  And  the following subjects exist:
  | s_id  |     s_name        | section |
  | cn202 | Data structure 1  | 680002  |
  Then I am on the home page
  And I follow "Go to show managed rooms for midterm"
  And I follow "Go to generate"
  Then I select "2015" from "start_date[year]"
  And I select "June" from "start_date[month]"
  And I select "26" from "start_date[day]"
  Then I select "2015" from "end_date[year]"
  And I select "June" from "end_date[month]"
  And I select "26" from "end_date[day]"
  And I select "Midterm" from "type"
  Then I press "Generate!!"
  And I should see "Data structure 1"
  And I should see "2015-06-26"
  And I should see "418"
  
Scenario: Generate success(midterm sad path:subject more than available day)
  Given the following locations exist:
  | room_no | total_table   | building    |
  | 418     | 23            | Engineering |
  And  the following subjects exist:
  | s_id  |     s_name        | section | 
  | cn202 | Data structure 1  | 680002  |
  | cn203 | Data structure 2  | 680003  |
  | cn204 | Data structure 3  | 680004  |
  Then I am on the home page
  And I follow "Go to show managed rooms for midterm"
  And I follow "Go to generate"
  Then I select "2015" from "start_date[year]"
  And I select "June" from "start_date[month]"
  And I select "26" from "start_date[day]"
  Then I select "2015" from "end_date[year]"
  And I select "June" from "end_date[month]"
  And I select "26" from "end_date[day]"
  And I select "Midterm" from "type"
  Then I press "Generate!!"
  And I should see "The amount of date is not enough"
  
Scenario: Generate success(midterm sad path:invalid date)
  Given the following locations exist:
  | room_no | total_table   | building    |
  | 418     | 23            | Engineering |
  And  the following subjects exist:
  | s_id  |     s_name        | section | 
  | cn202 | Data structure 1  | 680002  |
  Then I am on the home page
  And I follow "Go to show managed rooms for midterm"
  And I follow "Go to generate"
  Then I select "2015" from "start_date[year]"
  And I select "April" from "start_date[month]"
  And I select "31" from "start_date[day]"
  Then I select "2015" from "end_date[year]"
  And I select "April" from "end_date[month]"
  And I select "31" from "end_date[day]"
  And I select "Midterm" from "type"
  Then I press "Generate!!"
  And I should see "invalid date"
  
Scenario: Show midterm Managed Rooms
  Given the following locations exist:
  | room_no | total_table   | building    |
  | 418     | 23            | Engineering |
  And  the following subjects exist:
  | s_id  |     s_name        | section |
  | cn202 | Data structure 1  | 680002  |
  Then I am on the home page
  And I follow "Go to show managed rooms for midterm"
  And I follow "Go to generate"
  Then I select "2015" from "start_date[year]"
  And I select "June" from "start_date[month]"
  And I select "26" from "start_date[day]"
  Then I select "2015" from "end_date[year]"
  And I select "June" from "end_date[month]"
  And I select "26" from "end_date[day]"
  And I select "Midterm" from "type"
  Then I press "Generate!!"
  Then I should see table with room no "418" date time "2015-06-26"
  And I should see table with room no "418" date time "2015-06-26" with subject "Data structure 1-Free-Free-Free-Free-Free-Free-Free-Free-Free-Free-Free"

Scenario: Generate success(final)
  Given the following locations exist:
  | room_no | total_table   | building    |
  | 418     | 23            | Engineering |
  And  the following subjects exist:
  | s_id  |     s_name        | section |
  | cn202 | Data structure 1  | 680002  |
  Then I am on the home page
  And I follow "Go to show managed rooms for final"
  And I follow "Go to generate"
  Then I select "2015" from "start_date[year]"
  And I select "June" from "start_date[month]"
  And I select "26" from "start_date[day]"
  Then I select "2015" from "end_date[year]"
  And I select "June" from "end_date[month]"
  And I select "26" from "end_date[day]"
  And I select "Final" from "type"
  Then I press "Generate!!"
  And I should see "Data structure 1"
  And I should see "2015-06-26"
  And I should see "418"
  
Scenario: Generate success(final sad path:subject more than available day)
  Given the following locations exist:
  | room_no | total_table   | building    |
  | 418     | 23            | Engineering |
  And  the following subjects exist:
  | s_id  |     s_name        | section | 
  | cn202 | Data structure 1  | 680002  |
  | cn203 | Data structure 2  | 680003  |
  | cn204 | Data structure 3  | 680004  |
  Then I am on the home page
  And I follow "Go to show managed rooms for final"
  And I follow "Go to generate"
  Then I select "2015" from "start_date[year]"
  And I select "June" from "start_date[month]"
  And I select "26" from "start_date[day]"
  Then I select "2015" from "end_date[year]"
  And I select "June" from "end_date[month]"
  And I select "26" from "end_date[day]"
  And I select "Final" from "type"
  Then I press "Generate!!"
  And I should see "The amount of date is not enough"
  
Scenario: Generate success(final sad path:invalid date)
  Given the following locations exist:
  | room_no | total_table   | building    |
  | 418     | 23            | Engineering |
  And  the following subjects exist:
  | s_id  |     s_name        | section | 
  | cn202 | Data structure 1  | 680002  |
  Then I am on the home page
  And I follow "Go to show managed rooms for final"
  And I follow "Go to generate"
  Then I select "2015" from "start_date[year]"
  And I select "April" from "start_date[month]"
  And I select "31" from "start_date[day]"
  Then I select "2015" from "end_date[year]"
  And I select "April" from "end_date[month]"
  And I select "31" from "end_date[day]"
  And I select "Final" from "type"
  Then I press "Generate!!"
  And I should see "invalid date"
  
Scenario: Show final Managed Rooms
  Given the following locations exist:
  | room_no | total_table   | building    |
  | 418     | 23            | Engineering |
  And  the following subjects exist:
  | s_id  |     s_name        | section |
  | cn202 | Data structure 1  | 680002  |
  Then I am on the home page
  And I follow "Go to show managed rooms for final"
  And I follow "Go to generate"
  Then I select "2015" from "start_date[year]"
  And I select "June" from "start_date[month]"
  And I select "26" from "start_date[day]"
  Then I select "2015" from "end_date[year]"
  And I select "June" from "end_date[month]"
  And I select "26" from "end_date[day]"
  And I select "Final" from "type"
  Then I press "Generate!!"
  Then I should see table with room no "418" date time "2015-06-26"
  And I should see table with room no "418" date time "2015-06-26" with subject "Data structure 1-Free-Free-Free-Free-Free-Free-Free-Free-Free"