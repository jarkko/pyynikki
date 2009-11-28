# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20081212092337) do

  create_table "events", :force => true do |t|
    t.date     "event_date"
    t.integer  "temperature"
    t.string   "weather"
    t.text     "story"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "events", ["event_date"], :name => "index_events_on_event_date"

  create_table "roles", :force => true do |t|
    t.string   "name",              :limit => 40
    t.string   "authorizable_type", :limit => 40
    t.integer  "authorizable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "runners", :force => true do |t|
    t.integer  "birth_year",                    :null => false
    t.string   "first_name",                    :null => false
    t.string   "last_name",                     :null => false
    t.string   "sex",                           :null => false
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

  add_index "runs", ["event_id"], :name => "index_runs_on_event_id"
  add_index "runs", ["runner_id"], :name => "index_runs_on_runner_id"

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end
