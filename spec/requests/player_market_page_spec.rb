require 'spec_helper'

describe 'Player Market' do 

	subject {page}

	describe 'screen' do
		before(:each) do
			visit playerslist_path
		end


		it {should have_title(/Player Market/)}
		specify 'team profile produces correct players' do
			select "Arsenal", from: 'team_id'
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
	end
end