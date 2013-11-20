class Team < ActiveRecord::Base
	has_many :teamplayers
	validates :name, presence: true
	validates :cash, presence: true
	validates :activated_gameweek, presence: true
	validates :name, uniqueness: true
end
