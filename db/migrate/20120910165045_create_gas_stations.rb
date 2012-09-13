class CreateGasStations < ActiveRecord::Migration
  def change
    create_table :gas_stations do |t|
      t.string :name

      t.timestamps
    end
  end
end
