#encofding: utf-8
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
    click_link 'Konsult'
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

  describe "Diagrams", :type => :request do
    
    after(:all) do
      DataMapper.auto_migrate!
    end

    it 'when you arrive at the index page there should be no diagrams' do
      visit '/'
      page.should_not have_selector ".diagram"
    end 
    
    it 'Given an area exists, when you add a custom ability there should be a new diagram' do
      new_area = Area.new 
      new_area.name = "area_1"
      new_area.save

    end

    describe "Base tracks", :type => :request do
      before(:all) do
        new_area = Area.new 
        new_area.name = "area_1"
        new_area.save
        current_ability = Ability.use_ability(new_area.id, "ability_1")[:ability]
        new_track = ConsultantTrack.new 
        new_track.name = "consultant_track_1"
        new_track.abilities << current_ability
        new_track.save
      end

      it 'given a base track exists. When clickingadd_track base abilities should be added' do
        visit '/'
        click_button('add_track')
        page.should have_selector ".diagram" #validate a diagram was added
        page.should have_content('ability_1') #sloppy check that the diagram has the right text
      end
    end
  end
end
