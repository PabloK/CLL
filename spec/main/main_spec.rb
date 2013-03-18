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

  it 'shows a modal if the modal parameter is set' do
    visit '/'
    page.execute_script("setMessage('MODAL').modal();")
    page.should have_content('MODAL')
  end

  describe "Areas", :type => :request do
    before(:all) do
      new_area = Area.new 
      new_area.name = "area1"
      new_area.save
    end
    it 'given there are areas in the db they should be listed in the selectbox' do
      visit '/'
      within("#area") do
        page.should have_xpath "//option[text() = 'area1']"
      end
    end
  end
end
