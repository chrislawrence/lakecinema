require 'spec_helper'

describe Movie do
  it 'orders the showings by view index' do
    movie = create(:movie)
    movie.showings << [Showing.new(view_index: 1), Showing.new(view_index: 0)]
    expect(movie.showings.first.view_index).to eq(0)
  end

  it 'only downloads the poster if the url has changed' do
    movie = create(:movie)
    movie.stub(:save_poster_from_url).and_return(true)
    expect(movie).to receive(:save_poster_from_url)
      movie.update(poster_url: 'http://test.com/img.jpg')
  end

  it 'does not download the poster again if url has not changed' do
    movie = create(:movie)
    movie.stub(:save_poster_from_url).and_return(true)
    movie.update(poster_url: 'http://test.com/img.jpg')
    expect(movie).to_not receive(:save_poster_from_url)
    movie.update(poster_url: 'http://test.com/img.jpg')
  end

  it 'does not die if no  url is given' do
    movie = create(:movie, poster_url: "")
    expect(movie.poster.url).to eq('/assets/posters/missing.jpg')
  end
end
