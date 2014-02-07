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

	def balancesheet
		logger.debug "balancesheet params #{params[:id]}"
		if authorized_team(params[:id])
		  @team = Team.find_by(user_id: current_user.id)
		  @gameweeks = Gameweek.all
		  @balancesheet = @team.current_balance
		  
		end
	end

  private
  	  def authorized_team(team_id)
  	  	if team_id.to_i != Team.find_by(user_id: current_user.id).id
          redirect_to squad_team_players_url, alert: "Team id was tampered with, returning to squad screen"
          false
        else
          true
        end 
  	  end
	  def team_params
    	params.require(:team).permit(:name, :cash, team_players_attributes: 
    		[:team_id, :player_id, :placement, :buy_price, :buy_gameweek, :buy_date, :id, player_attributes: []])
  	  end  
end
