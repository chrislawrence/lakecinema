require 'spec_helper'

feature "Admin emails newsletter" do
  scenario 'from a valid email address' do
    email = 'c@chrislawrence.co'
    text = 'Welcome to the newsletter'
    newsletter = create(:newsletter)
    simulate_email_from(email, text)
    expect(newsletter.introduction).to eq(text)
  end

  scenario 'from a malicious email address' do
    email = 'spam@fake.com'
    text = 'This is spam'
    newsletter = create(:newsletter)
    simulate_email_from(email, text)
    expect(newsletter.introduction).to_not eq(text)
  end

  def simulate_email_from(email, text)
    page.driver.post('/email_processor', email_params(email, text))
  end
  
  def email_params(email, text)
    mandrill_events params_hash(email, text).to_json
  end

  def mandrill_events(json)
    { mandrill_events: json }
  end

  def params_hash(email, text)
    [{
      msg:
        {
          headers: {},
          text: text,
          from_email: email,
          subject: "hello",
          email: 'token@reply.example.com',
        }
    }]
  end
end
