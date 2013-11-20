class CreateTeamPlayers < ActiveRecord::Migration
  def change
    create_table :team_players do |t|
      t.string :placement         ,limit:2
      t.decimal :buy_price        ,precision:3, scale:1
      t.integer :buy_gameweek
      t.datetime :buy_date
      t.decimal :sell_price       ,precision:3, scale:1
      t.integer :deactivated_gameweek
      t.datetime :sell_date
      t.decimal :loyalty_bonus    ,precision:4, scale:2
      t.decimal :income           ,precision:4, scale:2

      t.timestamps
    end
  end
end
