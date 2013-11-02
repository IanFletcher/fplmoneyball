class PlayersController < ApplicationController
  def index
  	@players = Player.paginate(page: params[:page]).order('price DESC')

  end
end
