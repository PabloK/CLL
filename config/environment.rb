# encoding: utf-8
require 'active_support/core_ext/numeric/time'
require 'active_support/core_ext/date_time/calculations'
require 'rubygems'
require 'sinatra/base'
require 'sinatra/flash'
require 'data_mapper'
require 'uglifier'
require 'json'

class  Sinatra::Base
  
  # Show the current server configuration on startup
  if ENV['RACK_ENV']
    puts "[configuration] RACK_ENV : " + ENV['RACK_ENV']
  end
  
  # Settingup haml for quick render & no trace in production
  if ENV['RACK_ENV'] == 'production'
    set :haml, { :ugly => true }
    set :clean_trace, true
  end

  # Loading global variables
  require './config/globals'

  # Sets the standard dir in which haml looks for views
  set :views, File.dirname(__FILE__) + "/../views"
  
  # Register session based flash, currently used for message delivery
  register Sinatra::Flash

end

# Setup of logging for development & test
if ENV['RACK_ENV'] == 'development' or ENV['RACK_ENV'] == 'test'
  DataMapper::Logger.new($stdout, :debug)
end

# Setup of different databases for production, development & test
if ENV['RACK_ENV'] == 'test'
  DataMapper::setup(:default, ENV['TESTDATABASE_URL']) 
else
  DataMapper::setup(:default, ENV['DATABASE_URL'])
end
