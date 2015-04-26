class Subject < ActiveRecord::Base
   validates :s_id, :s_name, :section ,:duration, presence: true
   self.primary_key = 's_id'
   attr_accessible :s_id, :s_name,:section,:duration 
end
