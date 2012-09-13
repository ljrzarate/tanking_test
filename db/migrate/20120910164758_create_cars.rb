class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.integer :user_id
      t.string :brand
      t.string :model
      t.integer :year
      t.string :color

      t.timestamps
    end
  end
end
