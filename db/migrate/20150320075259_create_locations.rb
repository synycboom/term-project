class CreateLocations < ActiveRecord::Migration
  
  def change
    create_table :locations , {:id => false,:primary_key => :room_no} do |t|
      t.string :room_no
      t.decimal :total_table
      t.string :building
      t.timestamps
    end
  end
  
  def down
    drop_table :locations
  end
  
end
