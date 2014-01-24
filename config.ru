require 'sinatra/base'

require 'mongoid'
require './main'

Mongoid.load!('./config/mongoid.yml', :development)

Sinatra::Base.configure do |c|
  c.set :views, 'view'
end

run Pioneer::Main
