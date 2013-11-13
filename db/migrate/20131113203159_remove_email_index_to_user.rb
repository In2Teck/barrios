class RemoveEmailIndexToUser < ActiveRecord::Migration
  def up
    change_column :users, :email, :string, :null => true
    remove_index :users, :email
  end

  def down
    t.string :email, :null => false, :default => ""
    add_index :users, :email, :unique => true
  end
end
