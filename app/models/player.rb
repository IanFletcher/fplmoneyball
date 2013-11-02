class Player < ActiveRecord::Base

	self.per_page = 30

  	PLAYERSORT =  {
  	  "Total Score"=>         "totalscore", 
  	  "Round Score"=>         "round_score",
  	  "Price"=>               "price",
  	  "Teams Selected by %"=> "teams_selected_percentage",
  	  "Miniutes Played"=>     "miniutes_played",
  	  "Goals Scored"=>        "goals_scored",
  	  "Assists"=>             "assists",
  	  "Clean Sheets"=>        "clean_sheets",
  	  "Goals Conceded"=>      "goals_conceded",     
  	  "Own Goals"=>           "own_goals",
  	  "Penalties Saved"=>     "penaltles_saved",
  	  "Penalities Missed"=>   "penalties_missed",
  	  "Yellow Cards"=>        "yellow_cards",
  	  "Red Cards"=>           "red_cards",
  	  "Saves"=>               "saves",
  	  "Bonus"=>               "bonus",
  	  "Round Bonus"=>         "round_bonus",
      "Form"=>                "form",
      "Dream Team Appearances"=> "dream_team_appearances",
      "Value Form"=>           "value_form",
      "Value Season"=>         "value_season",
      "Points Per Game"=>      "points_per_game",
      "Transfers In"=>         "transfers_in",
      "Transfers Out"=>        "transfers_out",
      "Transfers In Round"=>   "transfers_in_round",
      "Transfers Out Round"=>  "transfers_out_round",
      "Price Rise"=>           "price_rise",
      "Price Fall"=>           "price_fall",
      "Price Rise Round"=>     "price_rise_round",
      "Price Fall Round"=>     "price_fall_round"
    } 

end
