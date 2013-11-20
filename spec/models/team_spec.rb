require 'spec_helper'

describe Team do
	let(:toecutters) { FactoryGirl.create(:team) }
	specify { FactoryGirl.create(:team).should be_valid }
	it { expect(toecutters).to respond_to(:name) }
	it { expect(toecutters).to respond_to(:cash) }
	it { expect(toecutters).to respond_to(:activated_gameweek) }		

	it 'should require name' do
		toecutters.name = ' '
		expect(toecutters).not_to be_valid
	end
	it 'should require cash' do
		toecutters.cash = ''
		expect(toecutters).not_to be_valid
	end
	it 'should require an active gameweek' do
		toecutters.activated_gameweek = ''
		expect(toecutters).not_to be_valid
	end
	it 'name should be unique' do
		uniquename = FactoryGirl.create(:team, name:'Vengence')
		expect(FactoryGirl.build(:team, name:'Vengence').error_on(:name)).to include("has already been taken")
	end
end
