namespace :calculate do
	desc "balacesheet"
	task :balancesheet => :environment do |variable|
	  team = Team.find(ENV["team_id"])
	  team.current_balancesheet
	end
end