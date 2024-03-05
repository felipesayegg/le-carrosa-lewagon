class AddCollumnSelledToCars < ActiveRecord::Migration[7.1]
  def change
    add_column :cars, :selled, :boolean
  end
end
