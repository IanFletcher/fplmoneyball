require 'spec_helper'

describe TeamPlayer do
  it 'has a default scope of no deactive players' do
  	notactive_team = FactoryGirl.create(:team_with_team_player)
  	notactive_team.team_players[0].deactivated_gameweek = 1
  	notactive_team.save
  	t = Team.find(notactive_team)
  	expect(t.team_players.count).to eq 0
  end
  it 'has a constant of position places' do
  	(TeamPlayer::POSITIONPLACES).should 
  	  match_array(['g1','g2','d1','d2','d3','d4','d5','m1','m2','m3','m4','m5','s1','s2','s3'])
	end
end
