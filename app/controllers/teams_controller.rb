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
		if authorized_team(params[:id])
		  @team = Team.find_by(user_id: current_user.id)
		  @gameweeks = Gameweek.all
		  @balancesheet = @team.current_balance
		end
	end

	def gwbalancesheet
		logger.debug "im here params #{params}"
		@balancesheet = GameweekBalancesheet.find_by(gameweek_id: params[:gameweek_id], team_id: params[:id])
		flash.now[:notice] = "Gameweek #{params[:gameweek_id]} balancesheet doesn't exist" unless @balancesheet.present?
		respond_to do |format|
			format.js
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
    		[:team_id, :player_id, :placement, :buy_price, :buy_gameweek, :buy_date, 
    			:id, :bench, player_attributes: []])
  	  end  
end
