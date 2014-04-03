class PlayerValues < ActiveModel::Validator
	def validate(team)
		@team = team
		fillin_team_players_values		
	end

	def fillin_team_players_values
		opengw = Gameweek.current
		newplayers = @team.team_players.select {|p| p if p.new_record?}
		t = Team.find_by(id: @team.id)
		tally = t.present? ? t.cash : 100.00
		arr = []
		@team.team_players.each do |ply|
			if ply.new_record?
				ply.buy_price = ply.player.price.round(2)
				ply.buy_gameweek = opengw.id
				ply.buy_date = DateTime.now
				tally -=  ply.player.price
			elsif swap_player? newplayers, ply
				ply.sell_date = DateTime.now
				ply.deactivated_gameweek = opengw.id
				ply.sell_price= ply.player.price
				tally += ply.player.price
			end
		end

		if @team.cash != (tally).round(2)
			@team.errors[:cash] << "#{@team.name} cash doesn't tally!"
		end
	end

	def swap_player?(newplayers, oldplayer)
		!newplayers.select {|h| h if h.placement == oldplayer.placement}.empty?
	end
end