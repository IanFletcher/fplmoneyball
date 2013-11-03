class AddTotalPointsAndTotalIncomeAndIncomeToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :total_points, :integer
    add_column :players, :total_income, :decimal, precision:4,scale:2
    add_column :players, :income, :decimal, precision:4,scale:2
  end
end
