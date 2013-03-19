class ProtectedController < Sinatra::Base
  before do
    no_logon = ["development","test"]
    login unless no_logon.include? ENV["RACK_ENV"]
  end
end
