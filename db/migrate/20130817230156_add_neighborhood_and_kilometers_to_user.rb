class AddNeighborhoodAndKilometersToUser < ActiveRecord::Migration
  def change
    add_column :users, :neighborhood_id, :integer
    add_column :users, :kilometers, :float
  end
end
