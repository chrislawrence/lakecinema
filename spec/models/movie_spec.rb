require 'spec_helper'

describe Movie do
  it 'orders the showings by view index' do
    movie = create(:movie)
    movie.showings << [Showing.new(view_index: 1), Showing.new(view_index: 0)]
    expect(movie.showings.first.view_index).to eq(0)
  end
end
