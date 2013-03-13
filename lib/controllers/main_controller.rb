# encoding: utf-8
class MainController < Sinatra::Base

    before do
      login unless ENV["RACK_ENV"] == "development"
      @diagram = true
    end

    get '/' do
      @consultant_tracks = ConsultantTrack.all()
      @domains = Domain.all
      @areas = @domains.first().areas()
      haml :index
    end

    post '/useAbility' do
      status = Ability.use_ability(params[:area],params[:ability])
      content_type 'application/json'
      return status.to_json 
    end

    post '/findAbility' do
      found_abilitys = Area.find_abilitys(params[:area],params[:ability])
      
      if found_abilitys
        abilitys = found_abilitys.map{|ability| ability.name}
        content_type 'application/json'
        abilitys.to_json
      end
    end
end
