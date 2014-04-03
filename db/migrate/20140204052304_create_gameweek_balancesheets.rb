class CreateGameweekBalancesheets < ActiveRecord::Migration
  def change
    create_table :gameweek_balancesheets do |t|
      t.integer :gameweek_id
      t.integer :team_id
      t.decimal :open_cash              ,precision:5, scale:2
      t.decimal :open_team_value        ,precision:5, scale:2
      t.decimal :player_earnings        ,precision:4, scale:2
      t.decimal :costs_variable         ,precision:4, scale:2
      t.decimal :costs_fixed            ,precision:4, scale:2
      t.decimal :transfer_fees          ,precision:4, scale:2
      t.decimal :player_exchange_value  ,precision:4, scale:2
      t.decimal :cash                   ,precision:5, scale:2
      t.decimal :team_value             ,precision:5, scale:2

      t.timestamps
    end
  end
end
