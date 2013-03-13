# encoding: utf-8
require './config/environment'
require './config/helpers'
require './lib/controllers'

map '/' do

  # Rack caching
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

  # Configure session settings
  use Rack::Session::Cookie, :secret => ENV['SESSION_SECRETE'], :expire_after => 30 * 3600

  # Configure menu
  $MENU = []
  $MENU.push({:text => "Mina nycklar", :url => "/"})
  $MENU.push({:text => "Administrera", :url => "/admin"})
  $MENU.push({:text => "Logga ut", :url => "/logout"})
  
  # Configuration for submenu helpers
  class Sinatra::Base
    def admin_menu
      @submenu = []
      @submenu.push({:text => "Kunskapsområden", :url => "/admin/domain/list"})
      @submenu.push({:text => "Kompetensområden", :url => "/admin/area/list"})
      @submenu.push({:text => "Konsultspår", :url => "/admin/consultant_track/list"})
    end
  end

  # Configuration of css and javascript compilation
  map '/css' do
    run SassCssConverter
  end

  map '/js' do
    run CoffeeJsConverter
  end
  
  # Standard paths
  map '/' do
    run MainController 
  end

  # Admin path will house all the administrative paths

  # TODO a good idea could be lifting the administrative specifics into an expanded Sinatra::Base class
  # This would reduce duplication and be all ower awesome. How ever not prioritized atm.
  map '/admin' do
    map '/area' do
      run AreaController
    end

    map '/consultant_track' do
      run ConsultantTrackController
    end

    map '/domain' do
      run DomainController
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
