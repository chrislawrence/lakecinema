require 'spec_helper'

feature 'user logs in' do
  scenario 'with correct credentials' do
    login
    expect(page).to have_content('Logged in')
  end

  scenario 'with bad credentials' do
    visit login_url
    fill_in 'email', with: 'fake@fake.com'
    fill_in 'password', with: 'fake'
    click_button 'Login'
    expect(page).to have_content('Email or password were invalid')
  end

end
