require 'spec_helper'

def pseudo_new_record(inst)
  inst.instance_eval do
   	def self.new_record?
   		true
   	end
  end
end

describe Team do
	let(:toecutters) { FactoryGirl.create(:team) }
	specify { FactoryGirl.create(:team).should be_valid }
	it { expect(toecutters).to respond_to(:name) }
	it { expect(toecutters).to respond_to(:cash) }
	it { expect(toecutters).to respond_to(:activated_gameweek) }		
	it { expect(toecutters).to respond_to(:current_balance) }		

	it 'should require name' do
		toecutters.name = ' '
		expect(toecutters).not_to be_valid
	end
	it 'should require cash' do
		toecutters.cash = ''
		toecutters.errors.messages.should include{/Cash doesn't add/}
	end
	it 'should require an active gameweek' do
		toecutters.activated_gameweek = ''
		expect(toecutters).not_to be_valid
	end
	it 'name should be unique' do
		uniquename = FactoryGirl.create(:team, name:'Vengence')
		expect(FactoryGirl.build(:team, name:'Vengence').error_on(:name)).to include("has already been taken")
	end
	describe 'cash adjustments' do
		let(:sting) { FactoryGirl.create(:team_with_team_player) }
		it 'must match with buys and sells' do
			pseudo_new_record(sting.team_players[0])
			sting.cash -= sting.team_players[0].player.price
			expect(sting.team_players[0]).to be_valid
		end
		it 'that dont equal produce an error message' do
			pseudo_new_record(sting.team_players[0])
			sting.should_not be_valid
			expect(sting.errors[:cash][0]).to match(/cash doesn't tally!/)
		end			
	end
	describe 'has current BalanceSheet' do
		let(:bs) {toecutters.current_balance}
		it 'instance' do
			bs.should be_an_instance_of GameweekBalancesheet
		end
		it 'with an open cash balance of $100' do
			expect(bs.open_cash).to eq (100.00)
		end
	end
end
