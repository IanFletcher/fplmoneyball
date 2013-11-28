class TeamPlayer < ActiveRecord::Base
	has_one :player
	has_one :team

	POSITIONPLACES = ['g1','g2','d1','d2','d3','d4','d5','m1','m2','m3','m4','m5','s1','s2','s3']
end
