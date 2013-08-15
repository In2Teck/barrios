class AddLastFacebookRunToUser < ActiveRecord::Migration
  def change
    add_column :users, :last_facebook_run, :datetime
  end
end
