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

ActiveRecord::Schema.define(version: 20140204070923) do

  create_table "gameweek_balancesheets", force: true do |t|
    t.integer  "gameweek_id"
    t.integer  "team_id"
    t.decimal  "open_cash",             precision: 4, scale: 2
    t.decimal  "open_team_value",       precision: 4, scale: 2
    t.decimal  "player_earnings",       precision: 4, scale: 2
    t.decimal  "costs_variable",        precision: 4, scale: 2
    t.decimal  "costs_fixed",           precision: 4, scale: 2
    t.decimal  "transfer_fees",         precision: 4, scale: 2
    t.decimal  "player_exchange_value", precision: 4, scale: 2
    t.decimal  "cash",                  precision: 4, scale: 2
    t.decimal  "team_value",            precision: 4, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "gameweeks", force: true do |t|
    t.boolean  "current"
    t.datetime "start_date"
    t.datetime "end_date"
    t.boolean  "open"
    t.boolean  "closed"
    t.string   "status",     limit: 30
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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

  create_table "team_players", force: true do |t|
    t.string   "placement",            limit: 2
    t.decimal  "buy_price",                      precision: 3, scale: 1
    t.integer  "buy_gameweek"
    t.datetime "buy_date"
    t.decimal  "sell_price",                     precision: 3, scale: 1
    t.integer  "deactivated_gameweek"
    t.datetime "sell_date"
    t.decimal  "loyalty_bonus",                  precision: 4, scale: 2
    t.decimal  "income",                         precision: 4, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "player_id"
    t.integer  "team_id"
    t.string   "bench"
  end

  add_index "team_players", ["player_id"], name: "index_team_players_on_player_id"
  add_index "team_players", ["team_id"], name: "index_team_players_on_team_id"

  create_table "teams", force: true do |t|
    t.string   "name",               limit: 30
    t.decimal  "cash",                          precision: 3, scale: 1
    t.integer  "activated_gameweek",                                    default: 1
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "teams", ["user_id"], name: "index_teams_on_user_id"

  create_table "users", force: true do |t|
    t.string   "email",                             default: "", null: false
    t.string   "encrypted_password",                default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                     default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "favorateclub",           limit: 30, default: "", null: false
    t.string   "firstname",              limit: 20, default: "", null: false
    t.string   "surname",                limit: 30, default: "", null: false
    t.string   "country",                limit: 30, default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
