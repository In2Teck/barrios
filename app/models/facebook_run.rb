class FacebookRun < ActiveRecord::Base
  attr_accessible :accounted, :miles, :pace, :run_id, :user_id
  belongs_to :user
end
