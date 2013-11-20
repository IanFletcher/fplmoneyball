require 'spec_helper'

describe Player do
	let(:frank) { FactoryGirl.create(:player) }
	specify { FactoryGirl.create(:player).should be_valid }
	it { expect(frank).to respond_to(:surname) }
	it { expect(frank).to respond_to(:firstname) }
	it { expect(frank).to respond_to(:position) }
	it { expect(frank).to respond_to(:club) }
	it { expect(frank).to respond_to(:round_score) }
	it { expect(frank).to respond_to(:price) }
	it { expect(frank).to respond_to(:teams_selected_percent) }
	it { expect(frank).to respond_to(:minutes_played) }
	it { expect(frank).to respond_to(:goals_scored) }
	it { expect(frank).to respond_to(:assists) }
	it { expect(frank).to respond_to(:clean_sheets) }
	it { expect(frank).to respond_to(:goals_conceded) }
	it { expect(frank).to respond_to(:own_goals) }
	it { expect(frank).to respond_to(:penalties_saved) }
	it { expect(frank).to respond_to(:penalties_missed) }
	it { expect(frank).to respond_to(:yellow_cards) }
	it { expect(frank).to respond_to(:red_cards) }
	it { expect(frank).to respond_to(:saves) }
	it { expect(frank).to respond_to(:round_bonus) }
	it { expect(frank).to respond_to(:form) }
	it { expect(frank).to respond_to(:dream_team_appearances) }
	it { expect(frank).to respond_to(:value_form) }
	it { expect(frank).to respond_to(:value_season) }
	it { expect(frank).to respond_to(:points_per_game) }
	it { expect(frank).to respond_to(:transfers_in) }
	it { expect(frank).to respond_to(:transfers_out) }
	it { expect(frank).to respond_to(:transfers_in_round) }
	it { expect(frank).to respond_to(:transfers_out_round) }
	it { expect(frank).to respond_to(:price_rise) }
	it { expect(frank).to respond_to(:price_fall) }
	it { expect(frank).to respond_to(:price_rise_round) }
	it { expect(frank).to respond_to(:price_fall_round) }
	it { expect(frank).to respond_to(:club_shortname) }
	it { expect(frank).to respond_to(:total_points) }
	it { expect(frank).to respond_to(:total_income) }
	it { expect(frank).to respond_to(:income) }
end


