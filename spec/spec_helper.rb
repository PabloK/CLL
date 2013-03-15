#encoding: utf-8
ENV['RACK_ENV'] = 'test'
require 'haml'
require './config/environment'
require 'rspec'
require 'capybara/rspec'
require 'capybara-webkit'
require 'rack'
require 'rack/test'

Capybara.default_driver = :webkit
RSpec.configure do |config|
  config.expect_with :rspec, :stdlib 
  config.filter_run_excluding :skip => true
  config.include Rack::Test::Methods
  config.include Capybara::DSL, :type => :request
  config.include Capybara::RSpecMatchers, :type => :request
end
Capybara.app = eval "Rack::Builder.new {#{File.read('./config.ru')}}"
DataMapper.auto_migrate!   
