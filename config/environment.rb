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
  $config = {}
  global_configuration = File.new(File.dirname(__FILE__) + "/globals.conf","r")
  while line = global_configuration.gets 
    line = line.delete("\n")
    name,value = line.split(":")
    $config[name.to_sym] = value
  end

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
