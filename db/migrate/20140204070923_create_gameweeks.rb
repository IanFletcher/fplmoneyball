class CreateGameweeks < ActiveRecord::Migration
  def change
    create_table :gameweeks do |t|
      t.boolean :current
      t.datetime :start_date
      t.datetime :end_date
      t.boolean :open
      t.boolean :closed
      t.string :status        ,limit:30

      t.timestamps
    end
  end
end