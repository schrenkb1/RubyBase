# routes/sessions.rb

module Sinatra
    module Routing
      module Sessions
        def self.registered(app)

	  app.get '/value/:name' do
	    "Hello, #{params[:name]}!"
	  end

	  app.not_found do
	    @title = "404 Not Found"
	    erb :"service/notfound"
	  end

	end
      end
    end
end
