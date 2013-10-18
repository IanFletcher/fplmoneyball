class AddClubShortNameToPlayers < ActiveRecord::Migration
  def change
  	add_column :players, :club_shortname, :string, :limit=>3
  end
end
