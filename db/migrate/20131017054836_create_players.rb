class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :surname                   ,limit:30
      t.string :firstname                 ,limit:30
      t.string :position                  ,limit:1
      t.string :club                      ,limit:30
      t.integer :parent_id
      t.integer :round_score
      t.decimal :price                    ,precision:3, scale:1               
      t.integer :teams_selected_percent
      t.integer :minutes_played
      t.integer :goals_scored
      t.integer :assists
      t.integer :clean_sheets
      t.integer :goals_conceded
      t.integer :own_goals
      t.integer :penalties_saved
      t.integer :penalties_missed
      t.integer :yellow_cards
      t.integer :red_cards
      t.integer :saves
      t.integer :round_bonus
      t.integer :bonus
      t.float :form
      t.integer :dream_team_appearances
      t.float :value_form
      t.float :value_season
      t.float :points_per_game
      t.integer :transfers_in
      t.integer :transfers_out
      t.integer :transfers_in_round
      t.integer :transfers_out_round
      t.decimal :price_rise
      t.decimal :price_fall
      t.decimal :price_rise_round
      t.decimal :price_fall_round
      t.integer :deactivated_gameweek
      t.integer :activated_gameweek                ,default:1

      t.timestamps
    end
  end
end
