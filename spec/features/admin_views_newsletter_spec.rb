require 'spec_helper'

feature "Admin views newsletter" do
  scenario "with the latest week" do
    login
    ProgrammeEditor.new(create(:week_with_movies_and_showings))
    visit admin_path
    click_link 'Newsletter'
    expect(page).to have_content Week.first.movies.first.title
  end
end
