# encoding: utf-8
require 'active_support/core_ext/numeric/time'
require 'active_support/core_ext/date_time/calculations'
require 'rubygems'
require 'sinatra/base'
require 'sinatra/flash'
require 'data_mapper'
require 'pony'
require 'uglifier'
require 'json'

class  Sinatra::Base
  
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

  # Mailer configuration
  options = {      
    :from => "noreply@asciisoccer.herokuapps.com",
    :via => :smtp,
    :via_options => {
        :user_name => ENV['SENDGRID_USERNAME'],
        :password => ENV['SENDGRID_PASSWORD'],
        :domain => "localhost",
        :address => "smtp.sendgrid.net",
        :port => 587,
        :authentication => :plain,
        :enable_starttls_auto => true
      }
    }
  Pony.options = options

end

# SQL logging settings
if ENV['RACK_ENV'] == 'development'
  DataMapper::Logger.new($stdout, :debug)
end
DataMapper::setup(:default, ENV['DATABASE_URL'])
