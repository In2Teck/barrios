class TwitterRun < ActiveRecord::Base
  attr_accessible :accounted, :miles, :pace, :run_url, :user_id
  belongs_to :user
end
