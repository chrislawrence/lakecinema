require 'spec_helper'

feature 'Admin edits copy' do
  before do
    login
    Page.create([{title: 'About'}, {title: 'Content'}])
  end

  scenario 'Edits about page and copy is updated' do
    click_link 'Edit Pages'
    within('.page-list') do
      click_link 'About'
    end
    fill_in 'Content', with: 'The new about page'
    click_button 'Save'
    visit(about_path)
    expect(page).to have_content('The new about page')
  end
end
