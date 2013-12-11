class TeamPlayer < ActiveRecord::Base
	belongs_to :player, inverse_of: :team_players
	belongs_to :team

	accepts_nested_attributes_for :player, allow_destroy: true

	default_scope -> { where("deactivated_gameweek IS NULL")}


	POSITIONPLACES = ['g1','g2','d1','d2','d3','d4','d5','m1','m2','m3','m4','m5','s1','s2','s3']
end
