class TeamsController < ApplicationController
	before_filter :auth_user
	
	def index
		render params
	end

	def new
	end

	def update
		@team = Team.find(params[:id])
		if @team.update_attributes!(team_params)
			redirect_to playerslist_url, notice: "Successfully updated"
		else
			render playerslist
		end
	end

  private

	  def team_params
    	params.require(:team).permit(:name, :cash, team_players_attributes: 
    		[:team_id, :player_id, :placement, :buy_price, :buy_gameweek, :buy_date, :id, player_attributes: []])
  	  end  
end
