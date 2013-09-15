class AddAttendeeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :attendee, :boolean, :default => false
  end
end
