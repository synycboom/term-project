# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
locations = [{:room_no => '418', :building => 'Engineering', :total_table => '35'},
    	  {:room_no => '315', :building => 'Engineering', :total_table => '40'},
    	  {:room_no => '318', :building => 'Engineering', :total_table => '25'},
      	  {:room_no => '507', :building => 'Engineering', :total_table => '45'},
      	  {:room_no => '609', :building => 'Engineering', :total_table => '30'},
  	 ]

locations.each do |location|
  Location.create!(location)
end

subjects = [{:s_id => 'cn201', :s_name => 'OOP', :section => '570001', :duration => '2'},
    	  {:s_id => 'cn202', :s_name => 'Data structure 1', :section => '680002', :duration => '2'},
    	  {:s_id => 'cn301', :s_name => 'Data structure 2', :section => '570003', :duration => '2'},
    	  {:s_id => 'cn418', :s_name => 'Web Application Security', :section => '340001', :duration => '2'},
    	  #{:s_id => 'cn350', :s_name => 'Microprocessor System Design', :section => '270008', :duration => '2'},
  	 ]

subjects.each do |subject|
  Subject.create!(subject)
end