require './spec/spec_helper'

describe MainController, :type => :request do
  it 'should display a menu' do
    visit '/'
    page.should have_selector '.navbar'
  end
end
