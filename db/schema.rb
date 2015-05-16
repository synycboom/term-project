# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20150516164750) do

  create_table "locations", :id => false, :force => true do |t|
    t.string   "room_no"
    t.decimal  "total_table"
    t.string   "building"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "manages", :force => true do |t|
    t.string   "room_no"
    t.date     "date"
    t.string   "slot1"
    t.string   "slot2"
    t.string   "slot3"
    t.string   "slot4"
    t.string   "slot5"
    t.string   "slot6"
    t.string   "slot7"
    t.string   "slot8"
    t.string   "slot9"
    t.string   "slot10"
    t.string   "slot11"
    t.string   "slot12"
    t.string   "slot13"
    t.string   "slot14"
    t.string   "slot15"
    t.string   "exam_type"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "manages_finals", :force => true do |t|
    t.string   "room_no"
    t.date     "date"
    t.string   "slot1"
    t.string   "slot2"
    t.string   "slot3"
    t.string   "slot4"
    t.string   "slot5"
    t.string   "slot6"
    t.string   "slot7"
    t.string   "slot8"
    t.string   "slot9"
    t.string   "slot10"
    t.string   "slot11"
    t.string   "slot12"
    t.string   "slot13"
    t.string   "slot14"
    t.string   "slot15"
    t.string   "exam_type"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "subjects", :id => false, :force => true do |t|
    t.string   "s_id"
    t.string   "s_name"
    t.string   "section"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
