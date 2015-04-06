require 'spec_helper'

feature 'admin views dashboard' do
  scenario 'and sees admin navigation' do
    login
    visit admin_path 
    expect(page).to have_content('New Programme')
  end

  scenario 'does not see admin navigation elsewhere' do
    visit about_path
    expect(page).to_not have_content('New Programme')
  end

end
