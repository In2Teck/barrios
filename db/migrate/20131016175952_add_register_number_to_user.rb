class AddRegisterNumberToUser < ActiveRecord::Migration
  def change
    add_column :users, :register_number, :integer, :default => 0
  end
end
