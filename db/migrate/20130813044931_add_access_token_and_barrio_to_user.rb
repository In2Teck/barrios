class AddAccessTokenAndBarrioToUser < ActiveRecord::Migration
  def change
    add_column :users, :access_token, :string
    add_column :users, :oauth_token, :string
    add_column :users, :oauth_token_secret, :string
    add_column :users, :barrio_id, :integer
  end
end
