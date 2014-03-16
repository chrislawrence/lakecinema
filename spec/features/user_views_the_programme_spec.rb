require 'spec_helper'

feature "User views the programme" do
  scenario "User goes to the home page and sees the programme" do
    week = create(:week)
    movie = create(:movie, week_id: week.id)
    visit '/'
    expect(page).to have_content(week.title)
    expect(page).to have_content(movie.title)
  end
end
