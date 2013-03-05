# encoding: utf-8
class AreaController < Sinatra::Base
  before do
    login
    @area = nil
    @message = flash[:message]
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
        modal({:heading => "Nytt Kompetensområde", :body => "Kompetensområdet #{@area} har sparats."})
        redirect '/area/list'
      end

      # TODO handle validation errors
      modal({:heading => "Ett fel uppstod", :body => "Kunde inte spara kompetensområdet."})
      new_area.errors.each do |e|
        puts e
      end
      return haml :area_add
    end

    modal({:heading => "Ett fel uppstod", :body => "Kompetensområdet #{@area} finns redan sedan tidigare."})
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
