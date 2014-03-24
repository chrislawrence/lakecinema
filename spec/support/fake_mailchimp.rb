require 'sinatra/base'

class FakeMailchimp < Sinatra::Base
  post '/2.0/campaigns/create.json' do
    json_response 200, 'mailchimp.json'
  end

  private

  def json_response(response_code, file_name)
    content_type :json
    status response_code
    File.open(File.dirname(__FILE__) + '/fixtures/' + file_name, 'rb').read
  end
end
