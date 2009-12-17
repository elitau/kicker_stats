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

ActiveRecord::Schema.define(:version => 20091217105656) do

  create_table "games", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "best_of"
  end

  create_table "matches", :force => true do |t|
    t.integer  "game_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "yellow_goals"
    t.integer  "white_goals"
    t.integer  "goals_to_win"
    t.string   "match_winner"
  end

  create_table "players", :force => true do |t|
    t.string   "username"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.string   "firstname"
    t.string   "lastname"
  end

  create_table "teams", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "player_id"
    t.integer  "match_id"
    t.integer  "team"
    t.string   "team_color"
  end

end
