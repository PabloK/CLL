# encoding: utf-8

# Filename: general.rb
# Author: Pablo Karlsson (Pablo.Karlsson@combitech.se)
#
# Description:
# General congfiguration that is not envirponment dependent

require 'sinatra/flash'
require 'sinatra/base'

# Opening Sinatra::Base to change settings
class Sinatra::Base

  # Loading global variables
  require './config/globals'

  # Set the haml view dir
  set :views, File.dirname(__FILE__) + "/../views"
  
  # Register session based flash
  # Is currently used for message delivery in the session
  register Sinatra::Flash
end
