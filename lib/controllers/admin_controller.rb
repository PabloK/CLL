# encoding: utf-8
class AdminController < ProtectedController
  before do
    @message = flash[:message]
  end

  get '/' do
    haml :admin
  end

end
