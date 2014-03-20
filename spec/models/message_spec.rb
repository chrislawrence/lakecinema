require 'spec_helper'

describe Message do
  it 'is a valid message' do
    expect(build(:message)).to be_valid
  end

  it 'is an invalid message' do
    expect(build(:invalid_message)).to_not be_valid
  end

  it 'sends the message to the mailer for organisation enquiries' do
    message = build(:message, nature: 'Organisations and Schools')
    ContactMailer.stub_chain(:new_message, :deliver)
    ContactMailer.should_receive(:new_message).with(message, Message::CINEMA_EMAIL)
    message.send_email
  end

  it 'sends the message to the mailer for website enquiries' do
    message = build(:message, nature: 'Website Issue')
    ContactMailer.stub_chain(:new_message, :deliver)
    ContactMailer.should_receive(:new_message).with(message, Message::WEBSITE_EMAIL)
    message.send_email
  end

end
