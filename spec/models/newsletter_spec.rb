require 'spec_helper'

describe Newsletter do
  it 'creates a mailchimp_campaign after saving' do
    Chimp.any_instance.should_receive(:send)
    create(:newsletter)
  end

  it 'saves the campaign id after saving' do
    newsletter = create(:newsletter)
    expect(newsletter.campaign_id).to_not be_nil
  end

  it 'receives a start_date and calculates a send date' do
    newsletter = Newsletter.new
    newsletter.set_content(Date.new(2014,04,02))
    expect(newsletter.send_time).to eq(Time.new(2014,04,01,8))
  end

  it 'makes a body string given an array of movies' do
    movies = [create(:movie)]
    newsletter = Newsletter.new
    newsletter.set_content(Date.today, movies)
    expect(newsletter.body).to include("<h2>#{movies.first.title}")
  end
end
