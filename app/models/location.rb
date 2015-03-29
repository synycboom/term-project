class Location < ActiveRecord::Base
  validates :room_no,:total_table ,:building, presence: true
  validates :total_table , numericality: { only_integer: true }
  self.primary_key = 'room_no'
  attr_accessible :room_no,:total_table,:building

end
