#encoding: utf-8
class LogoutController < Sinatra::Base

  get '/' do
    session.delete(:user)
    session.delete(:lookup)
    modal({:heading => "Utloggningen lyckades" ,:body => "Du har loggats ut ur systemet."})
    redirect '/login'
  end

end
