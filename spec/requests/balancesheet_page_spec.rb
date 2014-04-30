require 'spec_helper'

include SigninMod
include NavTest

describe 'Balancesheet screen' do
	subject {page}
	before(:each) do
		james_signin
		click_link 'Balancesheet'
	end
	it 'should work with all navigation', js: true do
		test_nav
	end
	it {should have_title(/BalanceSheet/)}
	it 'has an active gameweek' do
		within("#weekboxwindow") do
			should have_content(/Active/)
		end
	end
	describe 'accounts' do
		before(:each) do
			tm = Team.find_by(name: james_teamname)
			@bs = tm.current_balance
		end		
		it 'adds up previous gameweek tally' do
			opening_tally = (@bs.open_cash + @bs.open_team_value).round(2)
			within(".open_tally") do
				should have_content(opening_tally)
			end
		end
		it 'adds current gameweek net income' do
			net = (@bs.player_earnings + @bs.costs_variable + @bs.costs_fixed + 
						@bs.transfer_fees + @bs.player_exchange_value).round(2)
			within(".net_income") do
				should have_content(net.abs.to_s)
			end
		end
		it 'adds closing balance' do
			closing_balance = (@bs.cash + @bs.team_value).round(2)
			within('.closing_balance') do
				should have_content(closing_balance)
			end
		end
	end
	describe 'changing gameweek', js: true do
		before(:each) do
			@tm = Team.find_by(name: james_teamname)
			@bs = @tm.current_balance
		end
		it 'to previous gameweek' do
			prevgw = @bs.gameweek_id - 1
			bs_class = ".gameweek#{prevgw}"
			find("#{bs_class} .gwsubmit").click
			within(".activegw") do
				should have_content(prevgw)
			end 
		end
		it 'to future gameweek shouldnt work' do
			nextgw = @bs.gameweek_id + 1
			bs_class = ".gameweek#{nextgw}"
			find("#{bs_class} .gwsubmit").click
			should have_content("doesn't exist")
		end
		it 'hit right arrow' do
			furtherestgw = @bs.gameweek_id + 2
			find(".right").click
			should have_content("Gameweek:#{furtherestgw}")			
		end
		it 'hit left arrow' do
			leftgw = 1
			find(".left").click
			should have_content("Gameweek:#{leftgw}")			
		end
		it 'click current gameweek button' do
			prevgw = @bs.gameweek_id - 1
			bs_class = ".gameweek#{prevgw}"
			find("#{bs_class} .gwsubmit").click
			click_button("Current Gameweek")
			within(".activegw") do
				should have_content(@bs.gameweek_id)
			end
		end
	end
end