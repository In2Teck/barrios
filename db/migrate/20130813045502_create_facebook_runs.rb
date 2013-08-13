class CreateFacebookRuns < ActiveRecord::Migration
  def change
    create_table :facebook_runs do |t|
      t.integer :run_id
      t.float :miles
      t.float :pace
      t.boolean :accounted
      t.integer :user_id

      t.timestamps
    end
  end
end
