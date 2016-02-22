# routes/main.rb
# Think About MongoMapper or mongoid https://github.com/kunal/sinatra-mongodb-sample http://recipes.sinatrarb.com/p/models/mongo


module Sinatra
    module Routing
      module Main

        def self.registered(app)
require 'mongoid'
require_relative '../models/user'
	  app.get '/' do
	    @title = "Home Page"
	    erb :"pages/home"
	  end

	  app.get '/convert' do
	    status 200
	    headers \
	      "Allow"   => "BREW, POST, GET, PROPFIND, WHEN",
	      "TIDAL"   => "Adiend@3 Idne#2e3"
	    @title = "Convert"
	    erb :"pages/convert"
	  end

	  app.get '/match' do
	    @title = "Match"
	    erb :"pages/match"
	  end
	 
	  app.get '/collections/?' do
	    content_type :json
  	    settings.db.database.collection_names.to_json
	  end

          app.get '/add' do
            User.new(name: "Bob", email: "asdf@asd.com")
	    @title = "Data Added"
	    erb :"pages/match"
          end

	  app.get '/documents/?' do
	    content_type :json
	    settings.db.find.to_a.to_json
	  end

	  app.post '/new_document/?' do
	    content_type :json
	    result = settings.db.insert_one params
	    settings.db.find(:_id => result.inserted_id).to_a.first.to_json
	  end

	end
      end
    end
end
