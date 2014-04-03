class TeamPlayersController < ApplicationController
  before_filter :auth_user

  def index
    @team = Team.find_by(user_id: current_user.id)
    @team_players = TeamPlayer.where(team_id: @team.id)  
    respond_to do |format|
     format.html {render :squad }
    end
  end

  def update_multiple
    @team_players = TeamPlayer.find(params[:team_players].keys)
    @benchchange = tp_params
    if !validbench(@benchchange)
      redirect_to squad_team_players_url, alert: "Bench positions incorrect"
    else
      if TeamPlayer.update(@benchchange.keys, @benchchange.values)
        redirect_to squad_team_players_url, notice: "Successfully updated"
      else
        redirect_to squad_team_players_url
      end
    end
  end
  
  private

  def tp_params
    benchhash = {}
    params[:team_players].keys.each do |tp|
        benchhash[tp] =  {bench: params[:team_players][tp][0][:bench]}
    end
    #example -- {22 =>{bench: 'reservegoalie'}}
    benchhash 
  end
  def validbench(benchseats)
    benchnumbers = Hash.new(0)
    benchseats.each {|key, value| benchnumbers[value[:bench]] += 1 }
    benchnumbers == {"reserve1" => 1, "reserve2" => 1, "reserve3" => 1, "reservegoalie" => 1,  "" => 11}
  end
end
