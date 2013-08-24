#!/usr/bin/env ruby
ENV['RAILS_ENV'] = "production"
require File.dirname(__FILE__) + "/../config/environment"

runs_logger = Logger.new(File.join(Rails.root, 'log', 'runs_log.log'))

begin
  User.update_runs
  runs_logger.info("#{Time.now.in_time_zone('Central Time (US & Canada)').to_formatted_s(:short)} completed")
rescue => error
  runs_logger.error("#{Time.now.in_time_zone('Central Time (US & Canada)').to_formatted_s(:short)} ERROR'd: \n #{error.backtrace}")
end
