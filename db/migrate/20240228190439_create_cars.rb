class CreateCars < ActiveRecord::Migration[7.1]
  def change
    create_table :cars do |t|
      t.integer :year
      t.string :brand
      t.string :mod
      t.text :description
      t.float :price
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
