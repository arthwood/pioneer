require 'sinatra/base'
require './api/funds'
require './api/items'

module Pioneer
  class Main < Sinatra::Base
    get '/' do
      haml :index
    end

    get '/api/funds' do
      service = Pioneer::Api::Funds.new

      content_type :json
      
      service.get.map {|i| {id: i.id, name: i.name}}.to_json
    end

    get '/api/funds/:id' do
      service = Pioneer::Api::Items.new

      content_type :json

      service.get(params[:id]).map {|i| {date: i.date, value: i.value.present? ? i.value.to_f : nil}}.to_json
    end
  end
end
