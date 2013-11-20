class CreateTeams < ActiveRecord::Migration
  def change
  	create_table :teams do |t|
  		t.string :name								,limit:30
  		t.decimal :cash         					,precision:3, scale:1
  		t.integer :activated_gameweek               ,default:1


  		t.timestamps
  	end
  end
end
