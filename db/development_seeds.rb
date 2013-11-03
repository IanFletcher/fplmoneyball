# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Player.delete_all

puts "-- finish deletion --"

def ran(stuff)
	stuff.to_a[rand(stuff.size)]
end
position = %w{g g d d d d d m m m m m s s s}
club = {"Arsenal" =>"ARS","Chelsea" =>"CHE","Manchester United" => "MU",
	"Manchester City" => "MCI", "Tottenham" =>"TOT","Stoke"=>"STK",
	"Liverpool"=>"LIV","Southhampton" =>"STH", "Everton" => "EVE",
	"Hull" =>"HUL","Aston Villa" => "AVL", "Newcastle" =>"NEW",
	"West Brom"=>"WBA", "West Ham"=>"WHM", "Cardiff"=>"CAR", "Swansea"=>"SWA",
	"Fullham"=>"FUL","Norwich"=>"NOR","Crystal Palace"=>"CPA", "Sunderland"=>"SUN"}

score = [0,0,1,1,1,1,2,2,2,2,3,4,4,4,5,5,6,7,8]
goals = [0,0,0,0,0,0,0,0,1,1,1,1,2,3,4,5,6,7]
bonus = [0,0,0,0,0,0,0,0,0,0,1,1,1,2,3]
100.times do 
	clb = ran(club).first
	shortclb = club[clb]
	psn = ran(position)
	svs=psn=="g"?ran(goals):0
	price_rise_round = ran(bonus).to_f/10
	price_fall_round = price_rise_round == 0 ? ran(bonus).to_f/10 * -1 : 0
	Player.create(surname: Faker::Name.last_name, firstname: Faker::Name.first_name,
	position:psn, club: clb, round_score:ran(score),price:rand(40..100)/10,
	teams_selected_percent:rand(3..99), minutes_played:rand(50..2000),goals_scored:ran(goals),
	assists:ran(goals),clean_sheets:rand(10),goals_conceded:rand(15),
	own_goals:ran(goals),penalties_saved:ran(goals),penalties_missed:ran(goals),
	yellow_cards:ran(score),red_cards:ran(goals),saves:svs, round_bonus:bonus,
	bonus:rand(15),form:ran(score),dream_team_appearances:ran(bonus),
	value_form:ran(score)+(rand(10).to_f/10),value_season:ran(score)+(rand(10).to_f/10),
	points_per_game:ran(score)+(rand(10).to_f/10),transfers_in:rand(20000),
	transfers_out:rand(20000), transfers_in_round:rand(20000),
	transfers_out_round:rand(20000), price_rise: rand(10).to_f/10+price_rise_round,
	price_fall:(rand(10).to_f/10*-1)+price_fall_round, 
	price_rise_round:price_rise_round, price_fall_round:price_fall_round,
	club_shortname:shortclb, total_points:rand(40..200), 
	total_income:rand(90..2000)/100.00, income:rand(1..12)/10.0)
end