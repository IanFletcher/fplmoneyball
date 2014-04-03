module SigninMod
	def james_signin
		visit new_user_session_path
    fill_in 'Email', :with => 'james@gmail.com'
		fill_in 'Password', :with => 'password2'
		click_button 'Sign in'
	end
	def james_teamname
		'SydneySting'
	end
end