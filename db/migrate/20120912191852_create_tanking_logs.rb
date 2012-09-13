class CreateTankingLogs < ActiveRecord::Migration
  def change
    create_table :tanking_logs do |t|
      t.integer :car_id
      t.float :cost
      t.datetime :date
      t.float :gallon
      t.integer :gas_station_id
      t.integer :km

      t.timestamps
    end
  end
end
