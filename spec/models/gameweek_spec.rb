require 'spec_helper'

describe Gameweek do
  it 'has only one current week' do
  	expect(Gameweek.where(current: true).count).to be  <= 1
  end
  it 'has method to find current week' do
  	expect(Gameweek.current).to be_an_instance_of Gameweek
  end
  it 'status cannot be invalid' do
		gw = FactoryGirl.create(:gameweek)
		gw.status = 'wrong' 
		gw.should_not be_valid
		expect(gw.errors[:status][0]).to include("is not a valid option")
  end
end
