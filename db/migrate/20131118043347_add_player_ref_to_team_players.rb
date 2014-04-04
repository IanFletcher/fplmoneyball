class AddPlayerRefToTeamPlayers < ActiveRecord::Migration
  def change
  #  add_reference :team_players, :player, :reference
    add_column :team_players, :player_id, :integer
    add_index :team_players, :player_id
  end
end
