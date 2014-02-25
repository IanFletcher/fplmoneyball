class PlayersController < ApplicationController
  before_filter :auth_user

  helper_method :sort_column, :team_selection, :price_bands, :team_filter, :band
  def playerslist 
  #	@players = Player.selectclub(team_filter).bandlevel(band).paginate(page: params[:page]).order(sort_column + ' DESC')
    @players = Player.market_filter(team_filter, band, sort_column).paginate(page: params[:page])
    @team = Team.find_by(user_id: current_user.id)
    respond_to do |format|
      format.html
      format.js
    end
  end

  private
  def sort_column
    if defined?(params[:playersort][:id])
      Player.column_names.include?(params[:playersort][:id]) ? params[:playersort][:id] : "price"
    else
      "price"
    end  
  end
  def team_selection
    @clubmakup || ["All", "Goalies", "Defenders", "Midfielders", "Strikers"] + (Player.teams.map{|x| x.club})
  end
  def price_bands
    if defined? @bands
      @bands
    else
      max = Player.maximum(:price)
      min = Player.minimum(:price)
      steps = (max - min)/10.0
      @bands = [] 
      10.times { |x| @bands[x] = min + (steps * (x + 1.0))}
      @bands.reverse!
    end
  end
  def team_filter
    defined?(params[:teamselect][:id]) ? params[:teamselect][:id] : "All"
  end
  def band
    defined?(params[:priceband][:id]) ? params[:priceband][:id] : price_bands[0]
  end  
end
