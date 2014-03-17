require 'sinatra/base'

class FakeMailchimp < Sinatra::Base
  get '/creatCampaign' do
    json_response 200, 'caasdf23'
  end

  get 'updateCampaign' do
    json_response 200, 'asdfasdf'
  end

  private

  def json_response(response_code, file_name)
    content_type :json
    status response_code
    File.open(File.dirname(__FILE__) + '/fixtures/' + file_name, 'rb').read
  end
end
