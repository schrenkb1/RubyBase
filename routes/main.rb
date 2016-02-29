# routes/main.rb
# Think About MongoMapper or mongoid https://github.com/kunal/sinatra-mongodb-sample http://recipes.sinatrarb.com/p/models/mongo

module Sinatra
    module Routing
      module Main

	class Person
	  include Mongoid::Document
	  field :first_name
	  field :middle_name
	  field :last_name
          store_in collection: "item", database: 'map'
	end

	class Term
	  include Mongoid::Document
	  field :ud_table
	  field :ud_column
	  field :status
          store_in collection: "data", database: 'glossary'
	end

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
            #@data = User.new
            #(name: "Bob", email: "asdf@asd.com")
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
	    data = Term.new(ud_table: params['ud_table'],
                                ud_column: params['ud_column'],
                                status: params['status']
                               )
            data.save
            puts params
            @title = 'Data Added'
	    erb :"pages/convert"
	  end

	end
      end
    end
end
