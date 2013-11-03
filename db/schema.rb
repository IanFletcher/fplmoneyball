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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20131102064144) do

  create_table "players", force: true do |t|
    t.string   "surname",                limit: 30
    t.string   "firstname",              limit: 30
    t.string   "position",               limit: 1
    t.string   "club",                   limit: 30
    t.integer  "parent_id"
    t.integer  "round_score"
    t.decimal  "price",                             precision: 3, scale: 1
    t.integer  "teams_selected_percent"
    t.integer  "minutes_played"
    t.integer  "goals_scored"
    t.integer  "assists"
    t.integer  "clean_sheets"
    t.integer  "goals_conceded"
    t.integer  "own_goals"
    t.integer  "penalties_saved"
    t.integer  "penalties_missed"
    t.integer  "yellow_cards"
    t.integer  "red_cards"
    t.integer  "saves"
    t.integer  "round_bonus"
    t.integer  "bonus"
    t.float    "form"
    t.integer  "dream_team_appearances"
    t.float    "value_form"
    t.float    "value_season"
    t.float    "points_per_game"
    t.integer  "transfers_in"
    t.integer  "transfers_out"
    t.integer  "transfers_in_round"
    t.integer  "transfers_out_round"
    t.decimal  "price_rise"
    t.decimal  "price_fall"
    t.decimal  "price_rise_round"
    t.decimal  "price_fall_round"
    t.integer  "deactivated_gameweek"
    t.integer  "activated_gameweek",                                        default: 1
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "club_shortname",         limit: 3
    t.integer  "total_points"
    t.decimal  "total_income",                      precision: 4, scale: 2
    t.decimal  "income",                            precision: 4, scale: 2
  end

end
