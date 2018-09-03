require 'spec_helper'

feature "Admin sends newsletter without week" do
  scenario "with two movies" do
    login
    click_link 'New Newsletter'
    fill_in 'Send date', with: Date.tomorrow
    click_link 'Add Movie'
    fill_in 'Title', with: 'The Godfather'
    click_button 'Save'
    expect(page).to have_content 'Newsletter sent to Mailchimp'
  end
end
