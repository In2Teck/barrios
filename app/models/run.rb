class Run < ActiveRecord::Base
  attr_accessible :accounted, :kilometers, :pace, :published_date, :run_id, :run_url, :start_date, :user_id
end
