class MainController < Sinatra::Base
    get '/' do
      haml :index
    end

    post '/useTerm' do
      status = Term.use_term(params[:term])
      puts "status #{status}"
      content_type 'application/json'
      return status.to_json 
    end

    post '/findTerm' do
      found_terms = Term.find_terms(params[:term])
      terms = found_terms.map{|term| term.name}
      content_type 'application/json'
      terms.to_json
    end
end
