class AddBenchToTeamPlayers < ActiveRecord::Migration
  def change
    add_column :team_players, :bench, :string
  end
end
