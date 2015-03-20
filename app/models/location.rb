class Location < ActiveRecord::Base
  self.primary_key = 'room_no'
  attr_accessible :room_no,:total_table,:building
  
end
