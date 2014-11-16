require 'spec_helper'

describe Newsletter do

  it 'receives a start_date and calculates a send date' do
    newsletter = Newsletter.new
    Timecop.freeze Time.now do
      newsletter.set_content(Date.today + 2.days)
      expect(newsletter.send_time).to eq(Date.tomorrow + 8.hours)
    end
  end

  it 'makes a body string given an array of movies' do
    movies = [create(:movie)]
    newsletter = Newsletter.new
    newsletter.set_content(Date.today, movies)
    expect(newsletter.body).to include("<h4>#{movies.first.title}")
  end

  it 'sends to mailchimp' do
    newsletter = create(:newsletter)
    newsletter.stub(:movies).and_return([build(:movie)])
    expect(newsletter.send_to_mailchimp).to be_true
  end

  it 'sets the send time to 5 minutes from now if in the past' do
    Timecop.freeze Time.now do
      newsletter = create(:newsletter, send_time: Date.yesterday)
      newsletter.send_to_mailchimp
      expect(newsletter.send_time).to eq(5.minutes.from_now)
    end
  end

  it 'returns sent if send time is in the past' do
    Timecop.freeze Time.zone.now do
      newsletter = Newsletter.new(send_time: Time.zone.now - 1.day)
      expect(newsletter.sent).to eq(true)
    end
  end

  it 'does not include more info in body' do
    newsletter = create(:newsletter)
    newsletter.set_content(Date.today, [build(:movie)])
    expect(newsletter.body).to_not include('More info...')
  end

end
