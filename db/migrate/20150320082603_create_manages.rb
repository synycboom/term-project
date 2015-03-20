class CreateManages < ActiveRecord::Migration
  def change
    create_table :manages ,:id=>false do |t|
      t.string :room_no
      t.string :s_id
      t.string :conflict
      t.timestamps
    end
  end
end
