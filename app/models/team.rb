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
	validates_with PlayerValues, on: :update

	def current_balance
		gw = Gameweek.current
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

	private

		def find_balancesheet(gameweek_id)
			if gameweek_id
			  gameweek_balancesheets.find_by(gameweek_id: gameweek_id,  team_id: id)
			else
			  nil
			end
		end
end
