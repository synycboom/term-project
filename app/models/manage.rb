class Manage < ActiveRecord::Base
   attr_accessible :room_no, :date, :slot1, :slot2, :slot3, :slot4, :slot5, :slot6, :slot7,
   :slot8, :slot9, :slot10, :slot11, :slot12, :slot13, :slot14, :slot15
   #full indicates amount of days is not enough to manage
   @@full = false
   def self.full
    @@full
   end
   
   def self.full=n
    @@full = n
   end
  
end
