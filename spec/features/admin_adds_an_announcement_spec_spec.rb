require 'spec_helper'

feature "Admin adds an announcement spec" do
  before do
    login
  end
  scenario 'visits the admin page and adds an announcement' do
    save_and_open_page
    click_link 'New Programme'
    fill_in 'Start date', with: '2001-01-01'
    fill_in 'End date', with: '2001-01-02'
    choose 'Announcement'
    within '#announcement_fields' do
      fill_in 'Body', with: 'This is an announcement'
    end
    click_button 'Save'
    visit root_path
    expect(page).to have_content('This is an announcement')
  end
end
