#encoding: utf-8

# Filename: controller_types.rb
# Author: Pablo Karlsson (Pablo.Karlsson@combitech.se)
#
# Description:
# To avoid code duplication controllers with similar behaviour have been 
# extracted here to extend the Sinatra::Base calss

class ProtectedController < Sinatra::Base
  before do
    # For testing purposes, Login is only enabled in production
    no_logon = ["development","test"]
    lookup_user unless no_logon.include? ENV["RACK_ENV"]
  end
end
