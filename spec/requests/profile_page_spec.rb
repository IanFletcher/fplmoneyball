require 'spec_helper'

include SigninMod
include NavTest

describe 'Profile screen'  do
		subject {page}
	before(:each) do
		james_signin
		click_link 'Profile'
	end
		it 'should work with all navigation', js: true do
		test_nav
	end
	it {should have_title(/Edit User/)}
	describe 'changing attributes', js: true do
		it "update any field shouldn't work without password verification" do
			fill_in('user_favorateclub', with:'Leeds')
			click_button("Update")
			should have_content('error')
		end
		shared_examples_for "field" do |css_id, value, name|
			it "#{name} update" do
				fill_in('user_current_password', with: 'password2')
				fill_in(css_id, with: value)
				click_button("Update")
				should have_content('Account successfully updated')
			end
		end
		it_should_behave_like "field" , "user_favorateclub", "Leeds", :favorateclub
		it_should_behave_like "field" , "user_firstname", "Jack", :firstname
		it_should_behave_like "field" , "user_surname", "Jones", :surname
		it_should_behave_like "field" , "user_teams_attributes_0_name", "Spurs", :teamname
		it_should_behave_like "field" , "user_country", "America", :country
	end
	it 'can change to a new password', js: true do
		fill_in('user_current_password', with: 'password2')
		fill_in('user_password', with: 'newpassword')
		fill_in('user_password_confirmation', with: 'newpassword')
		click_button("Update")
		should have_content('Account successfully updated')
	end
end