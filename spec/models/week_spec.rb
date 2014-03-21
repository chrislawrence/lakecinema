require 'spec_helper'

describe Week do
  it 'generates the title based on the start and end dates' do
    week = create(:week, title: nil)
    expect(week.title).to eq("Weekend 14th, 15th, 16th March 2014")
  end

  it 'generates the holiday partial path' do
    week = create(:week)
    create(:holiday, week_id: week.id)
    expect(week.nested_partial_path).to eq('weeks/week_with_holidays')
  end

  it 'generates the movie partial path' do
    week = create(:week)
    create(:movie, week_id: week.id)
    expect(week.nested_partial_path).to eq('weeks/week_with_movies')
  end

  it 'returns a new newsletter if does not exist' do
    week  = create(:week)
    expect(week.get_or_build_newsletter).to be_a(Newsletter)
  end

  it 'returns a string of movie titles' do
    week = create(:week_with_two_movies)
    expect(week.movie_titles).to eq('2001 & The Godfather')
  end

  it 'orders the movies by view index' do
    week = create(:week)
    create(:movie, view_index: 1, week: week)
    create(:movie, view_index: 0, week: week)
    expect(week.movies.first.view_index).to eq(0)
  end

  it 'destroys the movies when destroying the week' do
    week = create(:week_with_movies_and_showings)
    week.destroy
    expect(Movie.count).to eq(0)
  end

end
