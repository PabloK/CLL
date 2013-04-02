#encoding: utf-8

# Filename: environment.rb
# Author: Pablo Karlsson (Pablo.Karlsson@combitech.se)
#
# Description:
# Configuration of production, development and test dependent settings

require 'active_support/core_ext/numeric/time'
require 'active_support/core_ext/date_time/calculations'
require 'rubygems'
require 'sinatra/base'
require 'data_mapper'
require 'uglifier'
require 'json'

# Show the current server environment on startup
if ENV['RACK_ENV']
  puts "[configuration] RACK_ENV : " + ENV['RACK_ENV']
end

# Enable logging for development & test
if ENV['RACK_ENV'] == 'development' or (ENV['RACK_ENV'] == 'test' and ENV['DEBUG'] == "ON")
  DataMapper::Logger.new($stdout, :debug)
end

# Setup of different databases for production, development & test
if ENV['RACK_ENV'] == 'test'
  DataMapper::setup(:default, ENV['TESTDATABASE_URL']) 
else
  DataMapper::setup(:default, ENV['DATABASE_URL'])
end

# Opening Sinatra::Base to change settings
class  Sinatra::Base
  
  # Settingup haml for quick render & no trace in production
  if ENV['RACK_ENV'] == 'production'
    set :haml, { :ugly => true }
    set :clean_trace, true
  end

end
