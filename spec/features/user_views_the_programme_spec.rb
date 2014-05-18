require 'spec_helper'

feature "User views the programme" do
  scenario "User goes to the home page and sees the programme" do
    week = create(:week)
    movie = create(:movie, week_id: week.id)
    visit '/'
    expect(page).to have_content(week.title)
    expect(page).to have_content(movie.title)
  end

  scenario "User clicks on a movie for more information" do
    create(:week_with_two_movies)
    visit '/'
    first('.poster').click
    expect(page).to have_content(Movie.first.overview)
  end
end
