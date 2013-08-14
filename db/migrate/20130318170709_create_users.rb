class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :facebook_id
      t.string :twitter_id
      t.string :first_name
      t.string :last_name
      t.text :facebook_hash
      t.text :twitter_hash
      t.string :first_twitt_id

      t.timestamps
    end
  end
end
