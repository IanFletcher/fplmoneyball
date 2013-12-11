class Team < ActiveRecord::Base
	has_many :team_players
	has_many :players, through: :team_players
	accepts_nested_attributes_for :team_players, allow_destroy: true

	validates :name, presence: true
	validates :cash, presence: true
	validates :activated_gameweek, presence: true
	validates :name, uniqueness: true

	before_validation :deactivate_old_players

	protected
	def deactivate_old_players
		newplayers = self.team_players.select {|p| p if p.new_record?}
		oldplayers = self.team_players.select {|p| p if !p.new_record?}
		logger.debug "new players #{newplayers} ... team count #{newplayers.length}"
		t = Team.find(self.id)
#		newplayers.each do |p|
#			squadplayer = t.team_players.find_by_placement(p.placement)
#			logger.debug "****squadplayer #{squadplayer.player.surname} new player #{p.player.surname} placement #{p.placement}"
#		end

		tally = t.cash
		arr = []
		self.team_players.each do |ply|
			if ply.new_record?
				ply.buy_price = ply.player.price
				ply.buy_gameweek = 1
				ply.buy_date = DateTime.now
				tally = tally - ply.player.price
				arr << ['NEW', ply.player.price.to_s, ply.player.surname, ply.player_id, ply.placement]
			elsif !newplayers.select {|h| h if h.placement == ply.placement}.empty?
				ply.sell_date = DateTime.now
				ply.deactivated_gameweek = 1
				ply.sell_price= ply.player.price
				tally = tally + ply.player.price
				arr << ['old', ply.player.price.to_s, ply.player.surname, ply.player_id, ply.placement]
			end
		end

		if self.cash != tally
			logger.debug "self.cash #{self.cash} tally #{tally} t.cash #{t.cash} arr #{arr} "
			errors.add(:cash , "#{self.name} cash doesn't tally.")
			raise Exception, "Cash doesn't add up"
		end
	end
end