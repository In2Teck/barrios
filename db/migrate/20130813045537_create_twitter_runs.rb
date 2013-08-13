class CreateTwitterRuns < ActiveRecord::Migration
  def change
    create_table :twitter_runs do |t|
      t.string :run_url
      t.float :miles
      t.float :pace
      t.boolean :accounted
      t.integer :user_id

      t.timestamps
    end
  end
end
