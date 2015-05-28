require 'spec_helper'

describe Movie do
  it 'orders the showings by view index' do
    movie = create(:movie)
    movie.showings << [Showing.new(position: 1), Showing.new(position: 0)]
    expect(movie.showings.first.position).to eq(0)
  end

  it 'only downloads the poster if the url has changed' do
    movie = create(:movie)
    allow(movie).to receive(:parse_image).and_return(true)
    expect(movie).to receive(:parse_image)
    movie.update(poster_url: 'http://test.com/img.jpg')
  end

  it 'does not download the poster again if url has not changed' do
    movie = create(:movie)
    allow(movie).to receive(:parse_image).and_return(true)
    movie.update(poster_url: 'http://test.com/img.jpg')
    expect(movie).to_not receive(:parse_image)
    movie.update(poster_url: 'http://test.com/img.jpg')
  end

  it 'handles no poster url being given' do
    movie = Movie.new(poster_url: '')
    movie.save
    expect(movie.poster.url).to include('missing')
  end

  it 'handles a bad poster url being given' do
    movie = Movie.new(poster_url: 'http://no-image')
    movie.save
    expect(movie.poster.url).to include('missing')
  end
  
  it 'destroys the showings when destroying the movie' do
    movie = create(:movie_with_showings)
    expect{movie.destroy}.to change{Showing.count}
  end

  it 'casts a string to array for cast' do
    movie = Movie.create(cast: 'Bill,Ted')
    expect(movie.cast).to eq(['Bill', 'Ted'])
  end

  it 'removes weird array stuff from cast string' do
    movie = Movie.create(cast: "{\"Bill\"},{\"Ted\"}")
    expect(movie.cast).to eq(['Bill', 'Ted'])
  end

end
