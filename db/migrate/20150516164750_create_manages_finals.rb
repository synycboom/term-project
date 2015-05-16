class CreateManagesFinals < ActiveRecord::Migration
  def change
    create_table :manages_finals do |t|
      t.string :room_no
      t.date :date
      t.string :slot1   #9:00-9:30
      t.string :slot2   #9:30-10:00
      t.string :slot3   #10:00-10:30
      t.string :slot4   #10:30-11:00
      t.string :slot5   #11:00-11:30
      t.string :slot6   #11:30-12:00
      t.string :slot7   #12:00-12:30
      t.string :slot8   #12:30-13:00
      t.string :slot9   #13:00-13:30
      t.string :slot10  #13:30-14:00
      t.string :slot11  #14:00-14:30
      t.string :slot12  #14:30-15:00
      t.string :slot13  #15:00-15:30
      t.string :slot14  #15:30-16:00
      t.string :slot15  #16:00-16:30
      t.string :exam_type #determine whether midterm or final 
      t.timestamps
    end
  end
end
