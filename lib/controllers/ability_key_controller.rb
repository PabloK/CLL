class AbilityKeyController < ProtectedController

  get '/key' do
      @diagram = true
      @consultant_tracks = ConsultantTrack.all()
      @areas = Area.all()
    
      haml :ability_key
  end

  get '/key/:id' do
    # TODO load key 

      @diagram = true
      @consultant_tracks = ConsultantTrack.all()
      @areas = Area.all()
    
      haml :ability_key
  end

  get '/key_list' do
    current_user = User.get(session[:user])
    if current_user
      @keys = current_user.ability_keys
      haml :key_list
    else
      redirect '/login'
    end
  end

end
