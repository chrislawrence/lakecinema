require 'spec_helper'

describe "Admin adds an announcement spec" do
  it 'visits the admin page and adds an announcement' do
    login
    click_link 'New week'
    fill_in 'Start date', with: '2001-01-01'
    fill_in 'End date', with: '2001-01-02'
    choose 'Announcement'
    click_button 'Save'
    expect(Week.last.announcement?).to be_true
  end
end
