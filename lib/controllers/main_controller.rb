# encoding: utf-8
class MainController < ProtectedController
    before do
      @diagram = true
    end

    get '/' do
      @consultant_tracks = ConsultantTrack.all()
      @areas = Area.all()
      haml :index
    end

    post '/useAbility' do
      #TODO area is not an id
      status = Ability.use_ability(params[:area],params[:ability])
      content_type 'application/json'
      return status.to_json 
    end

    post '/findAbility' do
      found_abilties = Area.find_abilities(params[:area],params[:ability])
      
      if found_abilties
        abilties = found_abilties.map{|ability| ability.name}
        content_type 'application/json'
        abilties.to_json
      end
    end

    post '/abiltiesForTrack' do
      track = ConsultantTrack.first(:name.like => params[:track])
      puts track
      if track
        if track.abilties 
          return track.abilties.to_json
        end
      else
        halt 404
      end
    end
end
