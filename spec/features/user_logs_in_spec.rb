require 'spec_helper'

feature 'user logs in' do
  scenario 'a user logs in given correct credentials and sees the dashboard' do
    login
    expect(page).to have_content('Dashboard')
  end

  scenario 'a user gives incorrect credentials and is not logged in' do
    visit login_url
    fill_in 'email', with: 'fake'
    fill_in 'password', with: 'fake'
    click_button 'Login'
    expect(page).to have_content('Email or password were invalid')
  end

end
