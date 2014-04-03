require 'spec_helper'
include SigninMod

describe 'Sign in screen' do
	describe 'without login' do
		it 'should redirect playermarket back to the signin screen' do
			visit playerslist_path
			current_path.should eq new_user_session_path
		end
		it 'should redirect playermarket back to the signin screen' do
			visit playerslist_path
			current_path.should eq new_user_session_path
		end
		it 'should redirect squad back to the signin screen' do
			visit squad_team_players_path
			current_path.should eq new_user_session_path
		end
		it 'should redirect balancesheet back to the signin screen' do
			visit balancesheet_team_path(1)
			current_path.should eq new_user_session_path
		end		
		it 'should redirect account profile back to the signin screen' do
			visit edit_user_password_path
			current_path.should eq new_user_session_path
		end		
	end
	it 'valid login should default to the playerlist screen' do
		james_signin
		current_path.should eq playerslist_path
	end
end