require 'spec_helper'

feature "Newsletter features" do
  scenario "A newsletter is written from the dashboard page" do
    create(:week_with_movies_and_showings)
    visit dashboard_path
    within('.week') do
      first(:link, "Write Newsletter").click 
    end
    fill_in "Introduction", with: "Welcome to the newsletter"
    click_button "Save"
    expect(page).to have_content("Newsletter sent to Mailchimp")
  end
end
