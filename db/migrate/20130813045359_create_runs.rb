class CreateRuns < ActiveRecord::Migration
  def change
    create_table :runs do |t|
      t.float :miles
      t.float :pace
      t.integer :date
      t.integer :user_id
      t.string :facebook_run_id
      t.string :twitter_run_id

      t.timestamps
    end
  end
end
