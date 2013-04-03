class AbilityKeyController < ProtectedController

  get '/key' do
      @diagram = true
      @consultant_tracks = ConsultantTrack.all()
      @areas = Area.all()
    
      haml :ability_key
  end

  get '/key/:id' do
    current_user = User.get(session[:user])
    current_key_id = params[:id].to_i
    redirect '/login' unless current_user
    @keys = current_user.ability_keys
    @key = @keys.find {|item| item.id == current_key_id}
    
    unless @key
      modal({:heading => "Fel" ,
              :body => "Nyckeln kunde inte hittas i databasen."})
    end
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
