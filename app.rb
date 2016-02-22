# app.rb
# http://www.sinatrarb.com/intro.html
# rackup -p 80 -E production


require 'sinatra'
require 'tilt/erb'
require 'mongo'
require 'json/ext'
require 'mongoid'

require_relative 'helpers'
require_relative 'routes/sessions'
require_relative 'routes/main'

class BaseApp < Sinatra::Base
    configure do
  if ENV['RACK_ENV'] === 'production'
    Mongoid.load!("mongoid.yml", :prod)
    set :mongo, Mongoid::Config::Environment.load_yaml("mongoid.yml", :prod)
    set :db, settings.mongo['sessions']['default']['database']
    set :hosts, settings.mongo['sessions']['default']['hosts']
    set :dump_errors, false
    set :show_exceptions, false
  else # development
    Mongoid.load!("mongoid.yml", :dev)
    set :mongo, Mongoid::Config::Environment.load_yaml("mongoid.yml", :dev)
    set :db, settings.mongo['clients']['default']['database']
    set :hosts, settings.mongo['clients']['default']['hosts']
    set :dump_errors, true
    set :show_exceptions, true
  end
    end
  set :sessions, true
  use Rack::Session::Cookie, :key => 'rack.session',
                             :domain => 'localhost',
                             :path => '/',
                             :expire_after => 2592000,
                             :secret => 'M3ga8yt3 5tuff',
                             :old_secret => 'M3ga8yt3 5tuff'
  set :views, 'views'
  set :public_folder, 'public'
  set :root, File.dirname(__FILE__)

  # Print out what you are running
  puts "You are currently running: " + ENV['RACK_ENV'] + ' database: '+settings.db+' hosts: '+ settings.hosts.to_s

  helpers Sinatra::Helpers
  register Sinatra::Routing::Main
  register Sinatra::Routing::Sessions

end

