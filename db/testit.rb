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


puts ran(position)

s = ran(club).first
puts s

score = [0,0,1,1,1,1,2,2,2,2,3,4,4,4,5,5,6,7,8]

puts ran(score)

x=5==10?'hello':"lesss"
puts x

bonus = [0,0,0,0,0,0,0,0,0,0,1,1,1,2,3]
price_rise_round= ran(bonus).to_f/10
puts "price rise #{price_rise_round}"