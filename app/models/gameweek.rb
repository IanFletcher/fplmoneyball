class Gameweek < ActiveRecord::Base
	has_many :gameweek_balacesheets

	validates :status, inclusion: { in: %w(Past Future Active),
	  message: "%{value} is not a valid option"}

	def self.current
		Gameweek.find_by(current:true)
	end
end
