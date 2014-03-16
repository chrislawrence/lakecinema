require 'spec_helper'

describe Search do
  it 'returns a JSON array of results' do
    get '/searches', params: {term: 'The Godfather'}
    expect(response.body).to include({label: 'The Godfather (1972)', id: 238}.to_json)
  end

  it 'returns a JSON array of a single film' do
    get '/searches/238'
    expect(JSON.parse(response.body)).to include("title" => "The Godfather")
  end
end
