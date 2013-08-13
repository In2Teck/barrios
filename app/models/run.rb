class Run < ActiveRecord::Base
  attr_accessible :date, :facebook_run_id, :miles, :pace, :twitter_run_id, :user_id
  belongs_to :user
end
