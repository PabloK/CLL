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
  # Startup info
  if ENV['RACK_ENV'] == 'development' 
    puts "[configuration] RACK_ENV : " + ENV['RACK_ENV']
  end
  
  # Production settings for haml
  if ENV['RACK_ENV'] == 'production'
    set :haml, { :ugly => true }
    set :clean_trace, true
  end

  # Global-variable configuration
  require './config/globals'

  # View dir configuration
  set :views, File.dirname(__FILE__) + "/../views"
  
  # Register session based flash
  register Sinatra::Flash

end

# SQL logging settings
if ENV['RACK_ENV'] == 'development'
  DataMapper::Logger.new($stdout, :debug)
end
DataMapper::setup(:default, ENV['DATABASE_URL'])
