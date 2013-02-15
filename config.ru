require './config/environment'
require './config/helpers'
require './lib/controllers'

map '/' do

  # Rack configuration for audio and images
  use Rack::Static, {
    :root => "public",
    :urls => ["/audio"],
    :content_type => "audio/mpeg",
    :cache_control => "public,max-age=#{365 * 24 * 3600}"
  }
  use Rack::Static, {
    :root => "public",
    :urls => ["/img"],
    :cache_control => "public,max-age=#{365 * 24 * 3600}"
  }
  use Rack::Static, {
    :root => "public",
    :urls => ["/robots.txt"],
    :cache_control => "public,max-age=#{365 * 24 * 3600}"
  }
  use Rack::Static, {
    :root => "public",
    :urls => ["/external/js"],
    :cache_control => "public,max-age=#{365 * 24 * 3600}"
  }

  use Rack::Session::Cookie, :secret => ENV['SESSION_SECRETE'], :expire_after => 30 * 3600


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

end 
