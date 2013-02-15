class MainController < Sinatra::Base
    get '/' do
      haml :index
    end
end
