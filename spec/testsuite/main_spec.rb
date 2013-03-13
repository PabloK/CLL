# Test setup
require './spec/spec_helper'

describe "Layout", :type => :request do
  
  it 'should display a menu' do
    visit '/'
    page.should have_selector '.navbar'
  end
  
  it 'should link to other pages when a link is pressed' do
    visit '/'
    first = page.html
    click_link 'Administrera'
    second = page.html
    expect(second).to_not eq(first)
  end 

  it 'show a modal if the modal parameter is set' do
    visit '/'
    page.execute_script("setMessage('MODAL').modal();")
    page.should have_content('MODAL')
  end
end
