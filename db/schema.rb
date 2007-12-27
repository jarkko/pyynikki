# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 4) do

  create_table "events", :force => true do |t|
    t.date     "event_date"
    t.integer  "temperature"
    t.string   "weather"
    t.text     "story"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "events", ["event_date"], :name => "index_events_on_event_date"

  create_table "runners", :force => true do |t|
    t.integer  "birth_year"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "sex"
    t.boolean  "outsider",   :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "runs", :force => true do |t|
    t.integer  "runner_id"
    t.integer  "event_id"
    t.integer  "time3600"
    t.integer  "time7600"
    t.integer  "time11200"
    t.integer  "time15200"
    t.boolean  "outsider",   :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "age_class"
  end

  add_index "runs", ["runner_id"], :name => "index_runs_on_runner_id"
  add_index "runs", ["event_id"], :name => "index_runs_on_event_id"

end
