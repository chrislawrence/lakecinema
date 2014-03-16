require 'spec_helper'

describe Newsletter do
  it 'creates a mailchimp_campaign after saving' do
    expect(MailchimpCampaign).to receive(:send)
    create(:newsletter)
  end

  it 'saves the campaign id after saving' do
    newsletter = create(:newsletter)
    expect(newsletter.campaign_id).to_not be_nil
  end

  it 'sends the campaign id along when it exists' do
    expect(MailchimpCampaign).to receive(:send).with(1)
    create(:newsletter, campaign_id: 1)
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
    expect(newsletter.body).to include("<h2>#{movies.first.title}</h2>")
  end
end
