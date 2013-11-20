class AddTeamRefToTeamPlayers < ActiveRecord::Migration
  def change
    add_reference :team_players, :team, index: true
  end
end
