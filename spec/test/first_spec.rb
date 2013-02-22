require './spec/spec_helper'

describe MainController, :type => :request do
  it 'Renders a menue' do
    visit '/'
    page.should have_selector('#menu')
    page.should have_selector('#header')
    page.should have_selector('#content')
  end
  it 'Renders content' do
    visit '/'
    page.should have_selector('#content')
  end
end
