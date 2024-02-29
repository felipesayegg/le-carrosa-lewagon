class AddKmColumnToCars < ActiveRecord::Migration[7.1]
  def change
    add_column :cars, :km, :integer
  end
end
