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

ActiveRecord::Schema.define(:version => 20111002003000) do

  create_table "questions", :force => true do |t|
    t.string   "status"
    t.integer  "room_id"
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rooms", :force => true do |t|
    t.string   "name"
    t.string   "status"
    t.integer  "vibe_threshold"
    t.integer  "question_threshold"
    t.integer  "teacher_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "ended_at"
    t.integer  "num_listeners"
  end

  create_table "teachers", :force => true do |t|
    t.string "email"
  end

  create_table "vibes", :force => true do |t|
    t.string   "vibe_type"
    t.integer  "room_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "votes", :force => true do |t|
    t.string   "vote_type"
    t.integer  "question_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
