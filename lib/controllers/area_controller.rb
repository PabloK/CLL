# encoding: utf-8
class AreaController < Sinatra::Base
  before do
    @area = nil
  end

  get '/' do
    haml :area_add
  end

  post '/' do
    @area = params[:name] ||= nil

    unless Area.exists(@area)
      new_area = Area.new 
      new_area.name = @area

      if new_area.save
        popup("Området har sparats.")
        return haml :area_add
      end

      # TODO handle validation errors
      popup("Kunde inte spara området.")
      new_area.errors.each do |e|
        puts e
      end
      return haml :area_add
    end

    popup("Området finns redan.")
    haml :area_add
  end

  get '/list' do
    @areas = Area.all()
    haml :area_list
  end
  
  post '/delete' do
    # TODO create accept delete question
  end

  delete '/delete' do
    # TODO create delete for areas
  end
end
