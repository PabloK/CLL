# encoding: utf-8
require './config/environment'
require './config/helpers'
require './lib/controllers'

map '/' do

  # Rack configuration for audio and images
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

  use Rack::Session::Cookie, :secret => ENV['SESSION_SECRETE'], :expire_after => 30 * 3600

  # Configure menu
  $MENU = []
  $MENU.push({:text => "Mina nycklar", :url => "/"})
  $MENU.push({:text => "Administrera", :url => "/area/list"})
  $MENU.push({:text => "Logga ut", :url => "/logout"})

  # Configuration of css and javascript compilation
  map '/css' do
    run SassCssConverter
  end

  map '/js' do
    run CoffeeJsConverter
  end

  map '/' do
    run MainController 
  end

  map '/area' do
    run AreaController
  end

  map '/login' do
    run LoginController
  end

  map '/logout' do
    run LogoutController
  end

end 
