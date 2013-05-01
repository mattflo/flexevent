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

ActiveRecord::Schema.define(:version => 20130501020048) do

  create_table "ballots", :force => true do |t|
    t.integer  "direction"
    t.integer  "voter_id"
    t.integer  "vote_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "ballots", ["vote_id"], :name => "index_ballots_on_vote_id"
  add_index "ballots", ["voter_id"], :name => "index_ballots_on_voter_id"

  create_table "events", :force => true do |t|
    t.string   "name"
    t.string   "location"
    t.string   "address"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.time     "event_time"
    t.datetime "voting_cutoff"
  end

  create_table "voters", :force => true do |t|
    t.string   "email"
    t.integer  "vote_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "event_id"
    t.string   "guid"
  end

  create_table "votes", :force => true do |t|
    t.date     "event_date"
    t.integer  "count"
    t.integer  "event_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
