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
      found_abilities = Area.find_abilities(params[:area],params[:ability])
      
      if found_abilities
        abilities = found_abilities.map{|ability| ability.name}
        content_type 'application/json'
        abilities.to_json
      end
    end

    post '/abilitiesForTrack' do
      track = ConsultantTrack.get(params[:track])
      if track
        if track.abilities 
          return track.abilities.to_json
        end
      else
        halt 400
      end
    end
end
