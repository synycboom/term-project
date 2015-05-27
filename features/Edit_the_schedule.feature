Feature: Edit the schedule
  As an admin
  So that I can edit the schedule
  I want to edit the schedule
  
Scenario: Edit success(midterm - inroom)
  Given the following locations exist:
  | room_no | total_table   | building    |
  | 418     | 23            | Engineering |
  And  the following subjects exist:
  | s_id  |     s_name        | section |
  | cn202 | Data structure 1  | 680002  |
  | cn203 | Data structure 2  | 680003  |
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
  And I should see table with room no "418" date time "2015-06-26" with subject "Data structure 1-Free-Free-Free-Free-Data structure 2-Free-Free-Free"
  Then I follow "Data structure 1"
  And I select "10.00 - 12.00" from "select_slot"
  And I select "room 418 : date 2015-06-26" from "select_date_room"
  Then I press "Edit"
  Then I should see table with room no "418" date time "2015-06-26"
  And I should see table with room no "418" date time "2015-06-26" with subject "Free-Free-Data structure 1-Free-Free-Data structure 2-Free-Free-Free"
  
Scenario: Edit success(midterm - inroom - sadpath)
  Given the following locations exist:
  | room_no | total_table   | building    |
  | 418     | 23            | Engineering |
  And  the following subjects exist:
  | s_id  |     s_name        | section |
  | cn202 | Data structure 1  | 680002  |
  | cn203 | Data structure 2  | 680003  |
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
  And I should see table with room no "418" date time "2015-06-26" with subject "Data structure 1-Free-Free-Free-Free-Data structure 2-Free-Free-Free"
  Then I follow "Data structure 1"
  And I select "13.30 - 15.30" from "select_slot"
  And I select "room 418 : date 2015-06-26" from "select_date_room"
  Then I press "Edit"
  Then I should see "the peroid you selected is not available"
  
Scenario: Edit success(midterm - diffrentroom)
  Given the following locations exist:
  | room_no | total_table   | building    |
  | 418     | 23            | Engineering |
  | 518     | 23            | Engineering |
  And  the following subjects exist:
  | s_id  |     s_name        | section |
  | cn202 | Data structure 1  | 680002  |
  | cn203 | Data structure 2  | 680003  |
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
  And I should see table with room no "418" date time "2015-06-26" with subject "Data structure 1-Free-Free-Free-Free-Data structure 2-Free-Free-Free"
  Then I follow "Data structure 1"
  And I select "9.00 - 11.00" from "select_slot"
  And I select "room 518 : date 2015-06-26" from "select_date_room"
  Then I press "Edit"
  Then I should see table with room no "518" date time "2015-06-26"
  And I should see table with room no "518" date time "2015-06-26" with subject "Data structure 1-Free-Free-Free-Free-Free-Free-Free-Free-Free-Free-Free"
  
Scenario: Edit success(midterm - diffrentroom - sadpath)
  Given the following locations exist:
  | room_no | total_table   | building    |
  | 418     | 23            | Engineering |
  | 518     | 23            | Engineering |
  And  the following subjects exist:
  | s_id  |     s_name        | section |
  | cn202 | Data structure 1  | 680002  |
  | cn203 | Data structure 2  | 680003  |
  | cn214 | Cryptography      | 680003  |
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
  And I should see table with room no "418" date time "2015-06-26" with subject "Data structure 1-Free-Free-Free-Free-Data structure 2-Free-Free-Free"
  Then I follow "Data structure 1"
  And I select "9.00 - 11.00" from "select_slot"
  And I select "room 518 : date 2015-06-26" from "select_date_room"
  Then I press "Edit"
  Then I should see "the peroid you selected is not available"
  
Scenario: Edit success(final - inroom)
  Given the following locations exist:
  | room_no | total_table   | building    |
  | 418     | 23            | Engineering |
  And  the following subjects exist:
  | s_id  |     s_name        | section |
  | cn202 | Data structure 1  | 680002  |
  | cn203 | Data structure 2  | 680003  |
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
  And I should see table with room no "418" date time "2015-06-26" with subject "Data structure 1-Free-Free-Free-Data structure 2"
  Then I follow "Data structure 1"
  And I select "10.00 - 13.00" from "select_slot"
  And I select "room 418 : date 2015-06-26" from "select_date_room"
  Then I press "Edit"
  Then I should see table with room no "418" date time "2015-06-26"
  And I should see table with room no "418" date time "2015-06-26" with subject "Free-Free-Data structure 1-Free-Data structure 2"
  
Scenario: Edit success(final - inroom - sadpath)
  Given the following locations exist:
  | room_no | total_table   | building    |
  | 418     | 23            | Engineering |
  And  the following subjects exist:
  | s_id  |     s_name        | section |
  | cn202 | Data structure 1  | 680002  |
  | cn203 | Data structure 2  | 680003  |
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
  And I should see table with room no "418" date time "2015-06-26" with subject "Data structure 1-Free-Free-Free-Data structure 2"
  Then I follow "Data structure 1"
  And I select "13.00 - 16.00" from "select_slot"
  And I select "room 418 : date 2015-06-26" from "select_date_room"
  Then I press "Edit"
  Then I should see "the peroid you selected is not available"  

Scenario: Edit success(final - differentroom)
  Given the following locations exist:
  | room_no | total_table   | building    |
  | 418     | 23            | Engineering |
  | 518     | 23            | Engineering |
  And  the following subjects exist:
  | s_id  |     s_name        | section |
  | cn202 | Data structure 1  | 680002  |
  | cn203 | Data structure 2  | 680003  |
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
  And I should see table with room no "418" date time "2015-06-26" with subject "Data structure 1-Free-Free-Free-Data structure 2"
  Then I follow "Data structure 1"
  And I select "9.00 - 12.00" from "select_slot"
  And I select "room 518 : date 2015-06-26" from "select_date_room"
  Then I press "Edit"
  Then I should see table with room no "518" date time "2015-06-26"
  And I should see table with room no "518" date time "2015-06-26" with subject "Data structure 1-Free-Free-Free-Free-Free-Free-Free-Free-Free"
  
Scenario: Edit success(final - differentroom - sadpath)
  Given the following locations exist:
  | room_no | total_table   | building    |
  | 418     | 23            | Engineering |
  | 518     | 23            | Engineering |
  And  the following subjects exist:
  | s_id  |     s_name        | section |
  | cn202 | Data structure 1  | 680002  |
  | cn203 | Data structure 2  | 680003  |
  | cn214 | Cryptography      | 680003  |
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
  And I should see table with room no "418" date time "2015-06-26" with subject "Data structure 1-Free-Free-Free-Data structure 2"
  Then I follow "Data structure 1"
  And I select "9.00 - 12.00" from "select_slot"
  And I select "room 518 : date 2015-06-26" from "select_date_room"
  Then I press "Edit"
  Then I should see "the peroid you selected is not available" 