require 'spec_helper'

describe Chimp do
  it 'creates a new campaign when no id is given' do
    sender = Chimp.new(attributes_for(:chimp))
    expect(sender).to receive(:create_campaign)
    sender.send
  end

  it 'updates a campaign when id is given' do
    sender = Chimp.new(attributes_for(:chimp, campaign_id: 1))
    expect(sender).to receive(:update_campaign)
    sender.send
  end

  it 'schedules a campaign when in the future' do
    sender = Chimp.new(attributes_for(:chimp))
    expect(sender).to receive(:schedule_campaign)
    sender.send
  end

  it 'sends a test email when campaign is scheduled' do
    sender = Chimp.new(attributes_for(:chimp))
    expect(sender).to receive(:send_test)
    sender.send
  end

end
