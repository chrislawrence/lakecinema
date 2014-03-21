require 'spec_helper'

describe "User edits programme" do
  it "edits the times and does not disrupt the order of things" do
    create(:week_with_movies_and_showings)
    visit dashboard_url
    within('.admin_week_list') do
      click_link 'Edit'
    end
    fill_in "Fri", with: "10pm"
    click_button 'Save'
    expect(page).to have_content('FRI: 5pm SAT: 10pm')
  end

  it "edits the movies and does not disrupt the order of things" do
    week = create(:week_with_movies_and_showings)
    create(:movie_with_showings, title: "Godfather II", week: week)
    visit edit_week_url(week, subdomain: 'admin')
    within('.movie.one') do
      fill_in 'Title', with: 'Godfather III'
    end
    click_button 'Save'
    within('.movie.one') do
      expect(page).to have_content('Godfather III')
    end
  end
end
