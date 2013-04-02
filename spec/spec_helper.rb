#encoding: utf-8

# Filename: spec_helper.rb
# Author: Pablo Karlsson (Pablo.Karlsson@combitech.se)
#
# Description:
# This file is a helper for the rakefile command rake spec.
# The file resets the configured testdatabase, setsup a server and
# executes the thests located in sub folders to the spec folder

require 'haml'
require 'rspec'
require 'capybara/rspec'
require 'capybara-webkit'
require 'rack'
require 'rack/test'

Capybara.default_driver = :webkit
Capybara.app = eval "Rack::Builder.new {#{File.read('./config.ru')}}"
DataMapper.auto_migrate!   
RSpec.configure do |config|
  config.expect_with :rspec, :stdlib 
  config.filter_run_excluding :skip => true
  config.include Rack::Test::Methods
  config.include Capybara::DSL, :type => :request
  config.include Capybara::RSpecMatchers, :type => :request
end
