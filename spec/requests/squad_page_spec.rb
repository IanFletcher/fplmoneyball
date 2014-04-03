require 'spec_helper'

include SigninMod
include NavTest

describe 'Squad Screen' do 
	subject {page}
	before(:each) do
		james_signin
		click_link 'Squad'
	end
	it 'should work with all navigation', js: true do
		test_nav
	end
	it {should have_title(/Squad/)}
	it 'should contain active squad', js: true do
		player_ids = Team.find_by(name: james_teamname).team_players.pluck(:player_id)
		squad_surnames = Player.find(player_ids).map(&:surname)
		squad_surnames.each {|name| should have_content(name) }
	end
	it 'has a reserve bench goalie', js: true do
		tm = Team.find_by(name: james_teamname)
		reserve_goalie = tm.team_players.select {|tp| tp.bench == 'reservegoalie' }[0]
		reserve_goalie = tm.team_players.select {|tp| tp.placement == 'g2' }[0] unless reserve_goalie
		within("#reservegoalie") do
			expect(reserve_goalie).to be_present
		end
	end
	describe 'changing reserves', js: true do
		it 'clicking transfer icon should change icon' do
			find("#reservegoalie .glyphicon-transfer").click
			should have_selector("#reservegoalie .glyphicon-hand-left")
		end
		it 'goalie for starting goalie' do
			reserve_goalie = find("#reservegoalie p").text
			find("#reservegoalie .glyphicon").click
			find("#footballground div[id^='g'] .glyphicon").click
			within("#footballground") do
				should have_content(reserve_goalie)
			end
		end
		it 'should not change a defender for a goalie' do
			reserve_defender = find("#reserve3 p").text
			find("#reserve3 .glyphicon").click
			find("#footballground #g1 .glyphicon").click
			within("#footballground") do
				should_not have_content(reserve_defender)
			end
		end
		it 'should change a defender for a striker' do
			reserve_defender = find("#reserve3 p").text
			find("#reserve3 .glyphicon").click
			find("#footballground #s1 .glyphicon").click
			within("#footballground") do
				should have_content(reserve_defender)
			end
		end
		it 'with invalid combo should come up with a modal form explaination' do
			reserve_defender = find("#reserve3 p").text
			find("#reserve3 .glyphicon").click
			find("#footballground #g1 .glyphicon").click
			within(".modal-body") do
				should have_content(/Wrong formation/)
			end
		end
		it 'should submit new team lineup' do
			reserve_defender = find("#reserve3 p").text
			find("#reserve3 .glyphicon").click
			find("#footballground #s1 .glyphicon").click
			click_button("Update First Team")
			should have_content(/Successfully updated/)
		end
	end
end
