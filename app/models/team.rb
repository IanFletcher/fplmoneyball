class Team < ActiveRecord::Base
	has_many :team_players, dependent: :destroy
	has_many :players, through: :team_players
	accepts_nested_attributes_for :team_players, allow_destroy: true

	belongs_to :user

	validates :name, presence: true
	validates :cash, presence: true
	validates :activated_gameweek, presence: true
	validates :name, uniqueness: true

	before_validation on: :create do
		self.cash = 100.00
	end
	before_validation :fillin_team_players_values, on: :update, unless: :testteam

	protected
	def fillin_team_players_values
		newplayers = self.team_players.select {|p| p if p.new_record?}
		t = Team.find_by(id: self.id)
		tally = t.present? ? t.cash : 100.00
		arr = []
		self.team_players.each do |ply|
			if ply.new_record?
				ply.buy_price = ply.player.price
				ply.buy_gameweek = 1
				ply.buy_date = DateTime.now
				tally = tally - ply.player.price
			elsif swap_player? newplayers, ply
				ply.sell_date = DateTime.now
				ply.deactivated_gameweek = 1
				ply.sell_price= ply.player.price
				tally = tally + ply.player.price
			end
		end

		if self.cash != (tally).round(2)
			logger.debug "self.cash #{self.cash} tally #{tally} t.cash #{t.cash} arr #{arr} "
			errors.add(:base , "#{self.name} cash doesn't tally.")
			raise Exception, "Cash doesn't add up"
		end
	end

	def swap_player?(newplayers, oldplayer)
		logger.debug "newplayer are #{newplayers} oldplayer is #{oldplayer}"
		!newplayers.select {|h| h if h.placement == oldplayer.placement}.empty?
	end

	def testteam
		name == 'SydneySting'
	end
end