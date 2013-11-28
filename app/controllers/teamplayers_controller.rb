class TeamplayersController < ApplicationController
  def teampersonel
 	#checkteamconstruction
  	render text: checkteamconstruction
  end

  private

  def checkteamconstruction
  	constructionerrors = []
  	hits =  TeamPlayer::POSITIONPLACES & params[:position]
  #	hits = ['g2','g1','d1','d2','d3','d4','d5','m1','m2','m3','m4','m5','s1','s2','s3'] & params[:position]
  	constructionerrors << 'Wrong number of valid positions' if TeamPlayer::POSITIONPLACES.length != hits
    constructionerrors << 'Wrong number of positions' if params[:position].length != 15
  
    team = Team.find(1)
    logger.debug "$$$$$$ #{team.cash}"

    playersselected = Player.find(params[:player_id])
    playerscost = playersselected.inject(0) {|sum, p| sum +=p.price }.round(2)
    logger.debug "$$$$$$ PLAYERS COST #{playerscost} number of players #{playersselected.length}"

  	#who has changed
  	originalplayers = TeamPlayer.where(team_id: 1).pluck(:player_id)
    logger.debug  "**** Original players #{originalplayers}"
  	if !originalplayers.empty?
  		playersleft = originalplayers & params[:player_id]
      logger.debug  "**** players left #{playersleft}"
  	end
  	#budget

  end
end
