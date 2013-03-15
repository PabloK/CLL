class ProtectedController < Sinatra::Base
  before do
    login unless ENV["RACK_ENV"] == "development" or ENV["RACK_ENV"] = "test"
  end
end
