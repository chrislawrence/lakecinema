require 'spec_helper'

feature "Newsletter features" do
  scenario "A newsletter is created when a week is created" do
    week = create(:week_with_two_movies)
    expect(Newsletter.last.body).to include(week.movies.first.title)

  end



end
