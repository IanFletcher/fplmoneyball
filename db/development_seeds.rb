# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

PLAYERNUMBER = 300

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

(PLAYERNUMBER).times do 
	clb = ran(club).first
	shortclb = club[clb]
	psn = ran(position)
	svs=psn=="g"?ran(goals):0
	price_rise_round = ran(bonus).to_f/10
	newprice = rand((40..100))/10.0.round(1)
	price_fall_round = price_rise_round == 0 ? ran(bonus).to_f/10 * -1 : 0
	Player.create(surname: Faker::Name.last_name, firstname: Faker::Name.first_name,
	position:psn, club: clb, round_score:ran(score),price:newprice,
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

puts "-- Finished adding #{PLAYERNUMBER} --"

User.delete_all
puts "*** delete all Users"

ian = User.create!(email: 'ianfletcher9@gmail.com', 
	favorateclub: 'Chelsea', firstname: 'Ian', surname: 'Fletcher',
	country: 'Australia', password: 'password1', 
	password_confirmation:'password1')

james = User.create!(email: 'james@gmail.com', 
	favorateclub: 'Manchester United', firstname: 'James', surname: 'Tweed',
	country: 'Australia', password: 'password2', 
	password_confirmation:'password2')

min = User.create!(email: 'min@gmail.com', 
	favorateclub: 'Manchester City', firstname: 'Min', surname: 'Kang',
	country: 'Australia', password: 'password3', 
	password_confirmation:'password3')
puts '*** added users ***'


Team.delete_all
TeamPlayer.unscoped.delete_all

puts "*** delete all teams"

Team.create(name: 'Toecutters', cash:100.00, activated_gameweek: 1, 
	user_id: ian.id)
Team.create(name: 'SydneySting', cash:10.00, activated_gameweek: 1, 
	user_id: james.id)
Team.create(name: 'Mins Giants', cash:100.00, activated_gameweek:1,
	user_id: min.id)

puts "-- Create a team for SydneySting --"
def addplayers(tm , squad)
	squad.each_with_index do |ply, i|
		plc = i + 1
		tm.team_players.build(player_id: squad[i].id, 
			buy_price: squad[i].price, buy_gameweek: 1, 
			buy_date: DateTime.now, placement: "#{squad[i].position}#{plc}")
			.save(validate: false)
	end
end
def squad_players(position, numbr)
	Player.where("position = ? and price <= ?", position, 6.5).limit(numbr)
end

t = Team.find_by(james)
addplayers(t, squad_players('g', 2))
addplayers(t, squad_players('d', 5))
addplayers(t, squad_players('m', 5))
addplayers(t, squad_players('s', 3))

teams = Team.all
puts "-- Finshed adding Teams #{teams.length}--"
Gameweek.delete_all

gw = DateTime.now
20.times do |i|
	st, ed = gw.beginning_of_week, gw.end_of_week
	gw = gw + 1.week
	if i == 3
		current = true
		status = 'Active'
		openon = true
	else
		status = i < 3 ? 'Past' : 'Future'
		current = false
		openon = false 
	end
	currentgw = Gameweek.create(current:current, 
	  start_date: st,
	  end_date: ed, open:openon, status:status)
end

puts "-- Added #{Gameweek.count} gameweeks --"