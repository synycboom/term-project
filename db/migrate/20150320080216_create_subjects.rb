class CreateSubjects < ActiveRecord::Migration
  def change
    create_table :subjects , {:id => false,:primary_key => :s_id}  do |t|
      t.string :s_id
      t.string :s_name
      t.string :section
      t.string :date
      t.string :time
      t.timestamps
    end
  end
  def down
    drop_table :subjects
  end
end
