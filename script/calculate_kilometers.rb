#!/usr/local/bin/ruby
ENV['RAILS_ENV'] = "development"
require '/var/www/vhosts/apps.t2omedia.com.mx/josecuervo/config/environment'
require 'rubygems'
require 'active_support/all'

User.update_runs
