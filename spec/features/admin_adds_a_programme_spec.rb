require 'spec_helper'

feature "Admin adds a programme" do
  before :each do
    @week = build(:week)
    login
end

  scenario "with basic week data" do
    fill_week_fields
    click_button 'Save'
    visit root_path
    expect(page).to have_content(@week.title)
  end

  scenario "with a movie" do
    fill_week_fields
    within('.movie-fields') do
      fill_in 'Title', with: 'The Godfather'
    end
    click_button 'Save'
    visit root_path
    expect(page).to have_content('The Godfather')
  end

  scenario "with session times" do
    fill_week_fields
    within('.movie-fields') do
      fill_in 'Title', with: 'The Godfather'
      fill_in 'week_movies_attributes_0_showings_attributes_0_times', with: '5pm'
    end
    click_button 'Save'
    visit root_path
    expect(page).to have_content('Friday: 5pm')
  end

  def fill_week_fields
    visit new_week_path
    fill_in 'Start date', with: @week.start_date
    fill_in 'End date', with: @week.end_date
  end
  
end
