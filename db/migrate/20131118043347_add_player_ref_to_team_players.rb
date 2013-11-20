class AddPlayerRefToTeamPlayers < ActiveRecord::Migration
  def change
    add_reference :team_players, :player, :reference
  end
end
