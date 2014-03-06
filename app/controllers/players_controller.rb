class PlayersController < ApplicationController
  before_filter :auth_user

 # helper_method :sort_column
  def playerslist 
    @player_presenter ||= PlayerPresenter.dropdowns
    @player_presenter.newplayers(player_market, sort_column)
    @team = Team.find_by(user_id: current_user.id)
    respond_to do |format|
      format.html
      format.js
    end
  end

  private
   def sort_column
     if defined?(params[:playersort][:id])
       Player.column_names.include?(params[:playersort][:id]) ? params[:playersort][:id] : "total_points"
     else
       "total_points"
     end  
   end
    def team_filter
     defined?(params[:teamselect][:id]) ? params[:teamselect][:id] : "All"
    end
    def band
     defined?(params[:priceband][:id]) ? params[:priceband][:id] : Player.maximum(:price)
    end
    def player_market
        Player.market_filter(team_filter, band, sort_column).paginate(page: params[:page])
    end
end
