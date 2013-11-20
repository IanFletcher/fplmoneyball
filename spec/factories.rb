FactoryGirl.define do
  factory :team do
    name   Faker::Company.name
    cash  100.00
    activated_gameweek  1
  end

  factory :player do
  	surname Faker::Name.last_name
  	firstname Faker::Name.first_name
  	position 'd'
  	club 'Arsenal'
  	round_score 10
  	price 12
  	teams_selected_percent 20
  	minutes_played 2500
  	goals_scored 3
  	assists 10
  	clean_sheets 6
  	goals_conceded 19
  	own_goals 2
  	penalties_saved 0
  	penalties_missed 0
  	yellow_cards 4
  	red_cards 0
  	saves 0
  	round_bonus 2
  	form 5.6
  	dream_team_appearances 2
  	value_form 6.0
  	value_season 4.1
  	points_per_game 3
  	transfers_in 23479
  	transfers_out 5783
  	transfers_in_round 383
  	transfers_out_round 4850
  	price_rise 1.2
  	price_fall 0.2
  	price_rise_round 0.1
  	price_fall_round 0.3
  	club_shortname "ARS"
  	total_points 125
  	total_income 7.2
  	income 0.22
  end
end