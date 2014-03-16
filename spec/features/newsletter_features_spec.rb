require 'spec_helper'

feature "Newsletter features" do
  scenario "A newsletter is written from the dashboard page" do
    week = create(:week_with_movies_and_showings)
    visit dashboard_url
    within('.week') do
      first(:link, "Write Newsletter").click 
    end
    fill_in "Introduction", with: "Welcome to the newsletter"
    click_button "Save"
    expect(page).to have_content("Newsletter sent to Mailchimp")
    expect(week.newsletter).to_not be_nil
  end

  scenario "An existing newsletter is edited" do
    week = create(:week_with_movies_and_showings)
    week.create_newsletter(introduction: 'Welcome to the newsletter')
    visit edit_newsletter_path(week)
    expect(page).to have_content('Welcome to the newsletter')
  end
end
