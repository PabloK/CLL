#encoding: utf-8
class LoginController < Sinatra::Base

  get '/' do
    haml :login
  end

  post '/' do
    sleep 1.0
    if params[:password] == ENV["CLL_PASS"]
      lookup = (0...50).map{ ('a'..'z').to_a[rand(26)]}.join
      session[:lookup]=lookup
      $CONFIG[:lookup].push(lookup)
      if $CONFIG[:lookup].length > 3
        $CONFIG[:lookup].shift()
      end
      redirect '/'
    end
    halt 403
  end

end
