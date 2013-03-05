#encoding: utf-8
class LogoutController < Sinatra::Base

  get '/' do
    session.delete(:lookup)
    redirect '/login'
  end

end
