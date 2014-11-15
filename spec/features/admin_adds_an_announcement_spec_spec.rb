require 'spec_helper'

describe "Admin adds an announcement spec" do
  it 'visits the admin page and adds an announcement' do
    login
    click_link 'New week'
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
