class CreateNeighborhoods < ActiveRecord::Migration
  def change
    create_table :neighborhoods do |t|
      t.string :name
      t.string :picture_url_thumb
      t.string :picture_url_normal
      t.string :picture_url_big

      t.timestamps
    end
  end
end
