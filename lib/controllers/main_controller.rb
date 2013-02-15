class MainController < Sinatra::Base
    get '/' do
      haml :index
    end

    post '/useTerm' do
       Term.use_term(params[:term])
    end

    post '/findTerm' do
      found_terms = Term.find_terms(params[:term])
      content_type 'application/json'
      terms = found_terms.map{|term| term.name}
      terms.to_json
    end
end
