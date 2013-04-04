# encoding: utf-8
class MainController < ProtectedController
    before do
      @message = flash[:message]
    end

    get '/' do
      # TODO find a reasonable index page no redirect
      redirect '/ability_key/key'
    end

    post '/useAbility' do
      #TODO area is not an id
      response = Ability.use_ability(params[:area],params[:ability])
      content_type 'application/json'
      return response.to_json 
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

    post '/saveAbiliyKey' do
      # TODO optimization
      # TODO Somehow warn about unexpected delete (Ajax call to check if name exists?)
        current_user = User.get(session[:user])
        if current_user
          
          new_ability_key = nil
          current_user.ability_keys.each do |existing_ability_key| 
            if existing_ability_key.name == params[:name]
              new_ability_key = existing_ability_key
              AbilityKeyAbilitySlider.all(:ability_key_id => existing_ability_key.id).destroy!
            end
          end

          new_ability_key = AbilityKey.new unless new_ability_key
          new_ability_key.name = params[:name]
          new_ability_key.edited = DateTime.now

          if params[:abilities]
            params[:abilities].each do |ab|
              ability = ab[1] 
              selected_ability = Ability.first(:name => ability[:name])
              # If no ability was found somthing is not right halt and display error
              halt 404 unless selected_ability 
              new_ability_slider = AbilitySlider.new
              new_ability_slider.current_level = ability[:current].to_i
              new_ability_slider.target_level = ability[:target].to_i
              new_ability_slider.ability = selected_ability
              new_ability_key.ability_sliders << new_ability_slider
            end
            new_ability_key.save
            current_user.ability_keys << new_ability_key
            if current_user.save
              content_type 'application/json'
              return "success".to_json
            end
          end
        end
      halt 404
    end

    get '/message/:heading/:body' do
      @message = {}
      @message[:body] = params[:body]
      @message[:heading] = params[:heading]
      haml :message , :layout => false
    end
end
