require 'sinatra/base'

class FakeTmdb < Sinatra::Base
  get '/3/search/movie' do
    json_response 200, 'movie_search.json'
  end

  get '/3/movie/:id' do
    json_response 200, 'movie.json'
  end

  get '/3/movie/:id/credits' do
    json_response 200, 'credits.json'
  end

  private

  def json_response(response_code, file_name)
    content_type :json
    status response_code
    File.open(File.dirname(__FILE__) + '/fixtures/' + file_name, 'rb').read
  end
end
