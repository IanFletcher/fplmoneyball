require 'spec_helper'

module SquadView
	def squad(arr)
		squadplayer = Struct.new(:surname, :placement)
		arr.collect {|p| squadplayer.new(p[0],p[1])}
	end
end
include SquadView
include SigninMod

describe 'Player Market' do 
	subject {page}

	describe 'screen' do
		before(:each) do
			james_signin
		end


		it {should have_title(/Player Market/)}
		specify 'team profile produces correct players' do
			select "Arsenal", from: 'teamselect_id'
			names = Player.where(club: 'Arsenal').order("price DESC").limit(30).pluck(:surname).join(' ')
			has_content?(names)
		end
		specify 'Sorting options produces correct players' do
			names = Player.order("yellow_cards DESC").limit(30).pluck(:surname).join(' ')
			has_content?(names)
		end
		specify 'lowest Price band produces correct players' do
			price_band = find_field('priceband_id').find('option:last').text
			names = Player.where("price <=?", price_band).order("price DESC").limit(30).pluck(:surname).join(' ')
			has_content?(names)
		end
		specify 'pagination links' do
			names = Player.order("price DESC").offset(30).limit(30).pluck(:surname).join(' ')
			find(:xpath, ".//*[@id='pagfixed2']/a[3]").click
			has_content?(names)
		end

		it 'the current squad is displayed on the football ground' do
			squadplayers = squad(Team.find_by(name: james_teamname).team_players.joins(:player).pluck(:surname, :placement))
			squadplayers.each do |ply|
				within(:css,  "##{ply.placement}") do
					has_content?(ply.surname)
				end
			end
		end
		it 'the squad has 15 players on football ground' do
			should have_css("#footballground .placement", :count => 15)
		end
		describe 'using transfers', js: true do
			def goalie_surname
				teamgoalies = []
		#		teamgoalies << find(:xpath, ".//*[@id='g1']/h4[1]").text
				teamgoalies << find(:css, "#g1 :nth-child(3)").text
				teamgoalies << find(:css, "#g2 :nth-child(3)").text
		#		teamgoalies << find(:xpath, ".//*[@id='g2']/h4[1]").text
				click_button('Goalies')
				sleep(1)
				surname = ''
				all("tbody>.playerdetails>.surname").each do |ply|
					if !teamgoalies.include?(ply.text) 
						surname =ply.text
						break
					end
				end
				surname
			end

			it 'remove second goalie from squad members' do
				find(:css, "#g2>.cross").click
				should_not have_css("#g2 img")
			end
			it 'change to a different player on football ground' do
				surname = goalie_surname
				find(:css, "#g2>.cross").click
				find(:css, "tbody>.playerdetails>.surname", text: surname).click
				should have_css("#g2", text: surname)
			end
			it 'changes the team cash when swapping a player' do
				surname = goalie_surname
				cash =find("#team_cash", :visible => false).value
				credit = find("#g2> .pprice").text
				find("#g2 .cross").click
				id = find(:css, "tbody>.playerdetails>.surname", text: surname).find(:xpath, "..")[:id]
				debit = find_by_id(id).find(".visprice").text
				find_by_id(id).click
				cash = (cash.to_f + credit.to_f - debit.to_f).to_s
				newtally = find('#team_cash', visible: false).value
				expect(newtally.to_f).to eq(cash.to_f)
			end
			it 'swapping players and hit update team brings new players in the team' do
				surname = goalie_surname
				find("#g2 .cross").click
				player_id = find(:css, "tbody>.playerdetails>.surname", text: surname).find(:xpath, "..")[:id]
				find_by_id(player_id).click
				click_button('personel')
				squadplayer = Team.find_by(name: james_teamname).team_players.find_by(player_id: player_id)
				expect(squadplayer.present?).to be_true
			end
		end
	end
end