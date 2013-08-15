class CreateRuns < ActiveRecord::Migration
  def change
    create_table :runs do |t|
      t.integer :user_id
      t.string :run_id
      t.string :run_url
      t.float :kilometers
      t.float :pace
      t.datetime :published_date
      t.datetime :start_date
      t.boolean :accounted

      t.timestamps
    end
  end
end
