require 'spec_helper'

describe Newsletter do

  it 'sets movies without belonging to a week' do
    movie = create(:movie)
    newsletter = Newsletter.create
    newsletter.set_content(Date.today, Date.tomorrow, [movie])
    expect(newsletter.movies).to include(movie)
  end

  it 'sets movies with a week' do
    week = create(:week_with_movies_and_showings)
    newsletter = week.build_newsletter
    newsletter.set_content
    expect(newsletter.movies).to eq(week.movies)
  end

  it 'sets start and end date without a week' do
    newsletter = Newsletter.new
    newsletter.set_content(Date.today, Date.tomorrow, [])
    expect(newsletter.start_date).to eq(Date.today)
  end

  it 'sets start and end date with a week' do
    week = create(:week_with_movies_and_showings)
    newsletter = week.build_newsletter
    newsletter.set_content
    expect(newsletter.start_date).to eq(week.start_date)
  end

end
