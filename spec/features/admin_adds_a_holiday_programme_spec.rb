require 'spec_helper'

feature "Admin adds a holiday programme" do
  before do
    login
  end

  scenario "Fill out the form to add a new holiday programme" do
    holiday = build(:holiday)
    visit new_week_url(subdomain: 'admin')
    fill_in 'Start date', with: Date.today
    fill_in 'End date', with: 2.days.from_now
    choose 'Holiday'
    within '#holiday_fields' do
      fill_in 'Preamble', with: holiday.preamble
      fill_in 'Body', with: holiday.body
    end
    click_button 'Save'
    visit root_path
    expect(page).to have_content(holiday.preamble)
  end

  scenario "Edit an existing holiday programme" do
    create(:week_with_holidays)
    visit dashboard_url
    click_link 'Edit'
    within '#holiday_fields' do
      fill_in 'Preamble', with: 'Edited version'
    end
    click_button 'Save'
    visit root_path
    expect(page).to have_content('Edited version')
  end

end
