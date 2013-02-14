class MainController < Sinatra::Base
    get '/' do
      @message = "Message tester close with Esc-key"
      haml :index
    end
end
