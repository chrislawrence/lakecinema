require 'spec_helper'

feature "Admin edits a programme" do
  before do
    login
  end

  scenario "with different times" do
    create(:week_with_movies_and_showings)
    visit dashboard_url
    within('.admin_week_list') do
      click_link 'Edit'
    end
    fill_in "Sat", with: "10pm"
    click_button 'Save'
    expect(page).to have_content('FRI: 5pm SAT: 10pm')
  end

  scenario "with different movie" do
    week = create(:week_with_movies_and_showings)
    create(:movie_with_showings, title: "Godfather II", week: week)
    visit edit_week_url(week, subdomain: 'admin')
    fill_in 'week_movies_attributes_0_title', with: 'Godfather III'
    click_button 'Save'
    within('.film.one') do
      expect(page).to have_content('Godfather III')
    end
  end
end
