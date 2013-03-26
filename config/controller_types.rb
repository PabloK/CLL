class ProtectedController < Sinatra::Base
  before do
    no_logon = ["development","test"]
    lookup_user unless no_logon.include? ENV["RACK_ENV"]
  end
end
