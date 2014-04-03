class AddNameIndexToTeams < ActiveRecord::Migration
  def change
  	add_index :teams, :name
  end
end
