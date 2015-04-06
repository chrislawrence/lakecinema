require 'spec_helper'

feature 'admin views dashboard' do
  scenario 'and sees admin navigation' do
    login
    visit admin_path 
    expect(page).to have_content('test')
  end

end
