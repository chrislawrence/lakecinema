require 'spec_helper'

describe Search do
  it 'returns results for a search term' do
    results = Search.by_title('The Godfather')
    expect(results.first[:label]).to eq("The Godfather (1972)")
  end

  it 'gets a movie given the id' do
    expect(Search.movie_by_id('256').title).to eq('The Godfather')
  end

  it 'gets the poster url based on path given' do
    expect(Search.movie_by_id('256').poster_url).to eq('http://image.tmdb.org/t/p/original/d4KNaTrltq6bpkFS01pYtyXa09m.jpg')
  end

  it 'sets the thumbnail url based on path given' do
    expect(Search.movie_by_id('256').poster_thumb).to eq('http://image.tmdb.org/t/p/w154/d4KNaTrltq6bpkFS01pYtyXa09m.jpg')
  end

  it 'sets the director' do
    expect(Search.movie_by_id('256').director).to eq('David Fincher')
  end

  it 'gets the first four actors' do
    expect(Search.movie_by_id('256').cast).to eq(["Edward Norton", "Brad Pitt", "Helena Bonham Carter", "Meat Loaf"])
  end

end
