module NavTest
	def test_nav
		current_page = find("#navigate .active a").text
		nav_pages ={"Player Market" => "Player Market", "Squad" => "Squad",
			"Balancesheet" => "BalanceSheet", "Profile" => "Edit User",
			"Sign Out" => "Sign in"}
		nav_pages.delete(current_page)
		nav_pages.each do |lnk, title|
			click_link(lnk)
			should have_title("FPLMoneyBall | #{title}") 
			click_link(current_page) unless lnk == "Sign Out"
		end
	end
	def visit_without_authentication
		visit playerslist_path
		current_path.should eq new_user_session_path
	end
end