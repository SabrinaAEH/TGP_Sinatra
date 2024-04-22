require_relative 'gossip'

class ApplicationController < Sinatra::Base
    get '/' do
        @gossips = Gossip.all
        erb :index
    end

    get '/gossips/new/' do 
        erb :new_gossip
    end

    post '/gossips/new/' do
        author = params["gossip_author"]
        content = params["gossip_content"]
        
        gossip = Gossip.new(Gossip.generate_id, author, content).save
        redirect '/'
    end

    get '/gossips/:id/' do
        id = params[:id].to_i
        @gossip = Gossip.find(id)
      
        if @gossip
          erb :show
        else
          "Aucun potin trouvé avec l'ID #{id}"
        end
    end
end
