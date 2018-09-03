require 'spec_helper'

feature "Admin edits a programme" do
  before :each do
    login
  end

  scenario "with different times" do
    create(:week_with_movies_and_showings)
    visit admin_path
    first('.controls').click_link('Edit')
    fill_in("Times", match: :first, with: "10pm")
    click_button 'Save'
    expect(page).to have_content('Fri: 10pm Sat: Noon and 5pm')
  end

  scenario "with different movie" do
    week = create(:week_with_movies_and_showings)
    create(:movie_with_showings, title: "Godfather II", week: week)
    visit edit_week_url(week)
    fill_in 'week_movies_attributes_0_title', with: 'Godfather III'
    click_button 'Save'
    expect(page).to have_content('Godfather III')
  end
end
