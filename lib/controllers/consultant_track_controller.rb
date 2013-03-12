# encoding: utf-8
class ConsultantTrackController < Sinatra::Base
  before do
    login unless ENV["RACK_ENV"] == "development"
    @consultant_track = nil
    @message = flash[:message]
    admin_menu
  end

  get '/' do
    haml :consultant_track_add
  end

  post '/' do
    @consultant_track = params[:name] ||= nil

    unless ConsultantTrack.exists(@consultant_track)
      new_consultant_track = ConsultantTrack.new 
      new_consultant_track.name = @consultant_track

      if new_consultant_track.save
        modal({:heading => "Nytt Konsultspår", :body => "Konsultspåret #{@consultant_track} har sparats."})
        redirect '/consultant_track/list'
      end

      # TODO handle validation errors
      modal({:heading => "Ett fel uppstod", :body => "Kunde inte spara konsultområdet."})
      new_consultant_track.errors.each do |e|
        puts e
      end
      return haml :consultant_track_add
    end

    modal({:heading => "Ett fel uppstod", :body => "Konsultspåret #{@consultant_track} finns redan sedan tidigare."})
    haml :consultant_track_add
  end

  get '/list' do
    @consultant_tracks = ConsultantTrack.all()
    haml :consultant_track_list
  end
  
  post '/delete' do
    # TODO create accept delete question
  end

  delete '/delete' do
    # TODO create delete for consultant_tracks
  end
end
