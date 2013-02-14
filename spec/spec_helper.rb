ENV['RACK_ENV'] = 'test'
require './config/environment'
require 'rspec'
require 'capybara/rspec'
require 'rack'
require 'rack/test'

RSpec.configure do |config|
  config.expect_with :rspec, :stdlib 
  config.filter_run_excluding :skip => true
  config.include Rack::Test::Methods
  config.include Capybara::DSL, :type => :request
  config.include Capybara::RSpecMatchers, :type => :request
  def app
    eval "Rack::Builder.new {#{File.read('./config.ru')}}"
  end
end
Capybara.app = eval "Rack::Builder.new {#{File.read('./config.ru')}}"
