# encoding: utf-8
class MainController < Sinatra::Base
    get '/' do
      @areas = Area.all
      haml :index
    end

    post '/useTerm' do
      status = Term.use_term(params[:area],params[:term])
      puts "status #{status}"
      content_type 'application/json'
      return status.to_json 
    end

    post '/findTerm' do
      found_terms = Area.find_terms(params[:area],params[:term])
      if found_terms
        terms = found_terms.map{|term| term.name}
        content_type 'application/json'
        terms.to_json
      end
    end
end
