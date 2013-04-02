# encoding: utf-8

# Filename: config.ru
# Author: Pablo Karlsson (Pablo.Karlsson@combitech.se)
#
# Description:
# This is the servers main configuration & startup file
# All sub application parts, menu & caching settings are configured here.

require './config/general'
require './config/environment'
require './config/helpers'
require './config/controller_types'
require './lib/controllers'
require './lib/models'


map '/' do

  # Configure session settings
  use Rack::Session::Cookie, :secret => ENV['SESSION_SECRETE'], :expire_after => 30 * 3600

  # Paths for static content with caching settings
  use Rack::Static, {
    :root => "public",
    :urls => ["/audio"],
    :content_type => "audio/mpeg",
    :cache_control => "public, max-age=81000"
  }
  use Rack::Static, {
    :root => "public",
    :urls => ["/img"],
    :cache_control => "public, max-age=81000"
  }
  use Rack::Static, {
    :root => "public",
    :urls => ["/robots.txt"],
    :cache_control => "public, max-age=81000"
  }
  use Rack::Static, {
    :root => "public",
    :urls => ["/external/js","/external/css", "/external/img"],
    :cache_control => "public, max-age=81000"
  }

  # Configuration for menu
  $MENU = []
  $MENU.push({:text => "Mina nycklar", :url => "/ability_key/key_list"})
  $MENU.push({:text => "Kompetensområden", :url => "/admin/area/list"})
  $MENU.push({:text => "Konsultspår", :url => "/admin/consultant_track/list"})

  # Paths fro css & javascript compilation
  map '/css' do
    run SassCssConverter
  end

  map '/js' do
    run CoffeeJsConverter
  end
  
  # Paths for Ajax calls and index
  map '/' do
    run MainController 
  end

  map '/ability_key' do
    run AbilityKeyController
  end

  # Admin path housing the administrative paths
  map '/admin' do
    map '/area' do
      run AreaController
    end

    map '/consultant_track' do
      run ConsultantTrackController
    end

    run AdminController
  end

  # Paths handling login and logout
  map '/login' do
    run LoginController
  end

  map '/logout' do
    run LogoutController
  end

end 
