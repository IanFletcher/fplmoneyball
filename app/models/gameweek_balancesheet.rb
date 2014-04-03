class GameweekBalancesheet < ActiveRecord::Base
	belongs_to :team
	belongs_to :gameweek
end
