class CreateCars < ActiveRecord::Migration[7.1]
  def change
    create_table :cars do |t|
      t.string :year
      t.string :brand
      t.string :mod
      t.text :description
      t.float :price
      t.string :url_fipe
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
