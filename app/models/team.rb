class Team < ActiveRecord::Base
	has_many :team_players, dependent: :destroy
	has_many :players, through: :team_players
	has_many :gameweek_balancesheets
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

	def current_balance
		gw = Gameweek.find_by(current:true)
		if !(bs = find_balancesheet(gw.id))
			bs = GameweekBalancesheet.new(team_id: id, gameweek_id: gw.id)
			if prev_bs = find_balancesheet((gw.id - 1))
				bs.open_cash = prev_bs.cash
				bs.open_team_value = prev_bs.team_value
			else
				bs.open_cash = 100.00
				bs.open_team_value = 0.0
			end
			bs.player_earnings = -1300.0
			bs.costs_variable = 0.0
			bs.costs_fixed = 0.0
			bs.transfer_fees = 0.0
			bs.player_exchange_value = 0.0
			bs.cash = cash
			bs.team_value = Player.joins(:team_players)
			  .where("team_players.deactivated_gameweek is null and 
			  	team_players.team_id = ?", id).sum(:price)
			bs.save
		end
		bs
	end

	def find_balancesheet(gameweek_id)
		if gameweek_id
		  gameweek_balancesheets.find_by(gameweek_id: gameweek_id,  team_id: id)
		else
		  nil
		end
	end

	protected
	def fillin_team_players_values
		opengw = Gameweek.find_by(open: true)
		newplayers = self.team_players.select {|p| p if p.new_record?}
		t = Team.find_by(id: self.id)
		tally = t.present? ? t.cash : 100.00
		arr = []
		self.team_players.each do |ply|
			if ply.new_record?
				ply.buy_price = ply.player.price.round(2)
				ply.buy_gameweek = opengw.id
				ply.buy_date = DateTime.now
				tally = tally - ply.player.price
			elsif swap_player? newplayers, ply
				ply.sell_date = DateTime.now
				ply.deactivated_gameweek = opengw.id
				ply.sell_price= ply.player.price
				tally = tally + ply.player.price
			end
		end

		if self.cash != (tally).round(2)
			errors.add(:base , "#{self.name} cash doesn't tally.")
			raise Exception, "Cash doesn't add up"
		end
	end

	def swap_player?(newplayers, oldplayer)
		!newplayers.select {|h| h if h.placement == oldplayer.placement}.empty?
	end

	def testteam
		name == 'test'
	end
end