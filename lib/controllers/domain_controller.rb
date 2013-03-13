# encoding: utf-8
class DomainController < Sinatra::Base
  before do
    login unless ENV["RACK_ENV"] == "development"
    @domain = nil
    @message = flash[:message]
    admin_menu
  end

  get '/' do
    haml :domain_add
  end

  post '/' do
    @domain = params[:name] ||= nil

    unless Domain.exists(@domain)
      new_domain = Domain.new 
      new_domain.name = @domain

      if new_domain.save
        modal({:heading => "Nytt Kunskapsområde", :body => "Kunskapsområdet #{@domain} har sparats."})
        redirect '/admin/domain/list'
      end

      # TODO handle validation errors
      modal({:heading => "Ett fel uppstod", :body => "Kunde inte spara kunskapsområdet."})
      new_domain.errors.each do |e|
        puts e
      end
      return haml :domain_add
    end

    modal({:heading => "Ett fel uppstod", :body => "Kunskapsområdet #{@domain} finns redan sedan tidigare."})
    haml :domain_add
  end

  get '/list' do
    @domains = Domain.all()
    haml :domain_list
  end
  
  post '/delete' do
    # TODO create accept delete question
  end

  delete '/delete' do
    # TODO create delete for domains
  end
end
