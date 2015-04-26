require 'spec_helper'

describe Newsletter do

  it 'sets send time for 8am on day of sending' do
    newsletter = build(:newsletter, start_date: 2.days.from_now)
    expect(newsletter.send_time).to eq(Date.tomorrow.to_datetime + 8.hours)
  end

  it 'updates send time to future if in past' do
    Timecop.freeze do
      newsletter = build(:newsletter, send_date: Date.today)
      newsletter.send_to_mailchimp
      expect(newsletter.send_time).to eq(5.minutes.from_now)
    end
  end

end
