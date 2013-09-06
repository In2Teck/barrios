class AddFbImgToNeighborhood < ActiveRecord::Migration
  def change
    add_column :neighborhoods, :fb_image, :string
  end
end
