require 'spec_helper'
require 'rack/test'
require './main'

describe Pioneer::Main do
  include Rack::Test::Methods

  def app
    Pioneer::Main
  end

  it 'should pass' do
    get '/'
    
    expect(last_response.status).to be(200)
  end
end
