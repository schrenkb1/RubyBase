# routes/main.rb
# Think About MongoMapper or mongoid https://github.com/kunal/sinatra-mongodb-sample http://recipes.sinatrarb.com/p/models/mongo

module Sinatra
    module Routing
      module Main

    # Load Mongoid Models
    require_relative '../models/person'
    require_relative '../models/term'

     def self.registered(app)

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
	 
	  app.get '/collections' do
  	    @values = Term.all
        @title = "All Term Data"
        erb :"pages/terms"
	  end

      app.get '/add' do
	    @title = "Add Data"
	    erb :"pages/add_data"
      end

	  app.get '/documents/?' do
	    content_type :json
	    person = Person.new(first_name: "Jean-Baptiste", middle_name: "Round")
	    person.save
	    print person.first_name
	  end

	  app.post '/new_document/?' do
	    data = Term.new(term: params['term'],
                            deffinition: params['deffinition'],
                            source_def: params['source_def'],
                            acronym: params['acronym'],
                            secure_class: params['secure_class'],
                            more_term: params['more_term'],
                            samp_val: params['samp_val'],
                            note: params['note'],
                            requester: params['requester'],
                            accept_dt: params['accept_dt'],
                            method: params['method'],
                            status: params['status']
                            )
            data.save
            @title = 'Data Added'
	    erb :"pages/convert"
	  end

	end
    end
    end
end
