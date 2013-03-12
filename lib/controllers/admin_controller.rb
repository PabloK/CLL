# encoding: utf-8
class AdminController < Sinatra::Base
  before do
    @message = flash[:message]
    admin_menu
  end

  get '/' do
    haml :admin
  end

end
