require './spec/spec_helper'

describe MainController, :type => :request do
  it 'Renders Hello world' do
    visit '/'
    page.should have_content 'Hello world'
  end
end
