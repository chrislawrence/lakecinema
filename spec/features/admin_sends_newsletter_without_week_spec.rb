require 'spec_helper'

feature "Admin sends newsletter without week" do
  scenario "with two movies" do
    login
    click_link 'New Newsletter'
    fill_in 'Title', with: 'School Holiday Programme'
    fill_in 'Send time', with: Date.tomorrow
    within '.film' do
      fill_in 'Title', with: 'The Godfather'
    end
    click_button 'Save'
    expect(page).to have_content 'Newsletter sent to Mailchimp'
  end
end
