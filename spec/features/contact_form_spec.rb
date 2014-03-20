require 'spec_helper'

feature "Contact form" do
  scenario "User sends a valid email" do
    message = build(:message)
    visit contact_path
    select "Organisations and Schools", from: 'message[nature]'
    fill_in 'Name', with: message.name
    fill_in 'Email', with: message.email
    fill_in 'Your Message', with: message.body
    click_button 'Send'
    expect(page).to have_content('Your message has been delivered. Thankyou.')
  end

  scenario "User submits an invalid message and can edit it" do
    message = build(:invalid_message)
    message.valid?
    visit contact_path
    select "Organisations and Schools", from: 'message[nature]'
    fill_in 'Name', with: message.name
    fill_in 'Email', with: message.email
    fill_in 'Your Message', with: message.body
    click_button 'Send'
    expect(page).to have_content(message.body)
    expect(page).to have_content("Please fill in all fields")
  end
end
