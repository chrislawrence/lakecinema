require 'spec_helper'

feature "Admin adds a programme" do
  before do
    @week = build(:week)
  end

  scenario "User fills out the form to add a new week" do
    fill_week_fields
    click_button 'Save'
    expect(page).to have_content(@week.title)
  end

  scenario "User adds a movie" do
    fill_week_fields
    within('.movie.one') do
      fill_in 'Title', with: 'The Godfather'
    end
    click_button 'Save'
    expect(page).to have_content('The Godfather')
  end

  scenario "User adds times" do
    fill_week_fields
    within('.movie.one') do
      fill_in 'Title', with: 'The Godfather'
     fill_in 'Fri', with: '5pm'
    end
    click_button 'Save'
    expect(page).to have_content('Fri: 5pm')
  end

  scenario "User adds a holiday programme" do
    holiday = build(:holiday)
    fill_week_fields
    page.check('Holidays')
    fill_in 'Preamble', with: holiday.preamble
    fill_in 'Body', with: holiday.body
    click_button 'Save'
    expect(page).to have_content(holiday.preamble)
  end

  def fill_week_fields
    visit new_week_url(subdomain: 'admin')
    fill_in 'Start date', with: @week.start_date
    fill_in 'End date', with: @week.end_date
  end
  
end
