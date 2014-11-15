require 'spec_helper'

feature "Newsletter email" do

  scenario 'admin emails the site to add an introduction to the newsletter' do
    create(:newsletter)
    message = 'Hello'
    page.driver.post email_processor_path
    expect(Newsletter.first.introduction).to include(message)
  end

  def fake_message(message)
    {
      to: 'Lake Cinema <robot@lakecinema.net.au>',
      from: 'Chris Lawrence <c@chrislawrence.co>',
      text: message
    }
  end
def email_params
    {
      headers: 'Received: by 127.0.0.1 with SMTP...',
      to: 'thoughtbot <tb@example.com>',
      cc: 'CC <cc@example.com>',
      from: 'John Doe <someone@example.com>',
      subject: 'hello there',
      text: 'this is an email message',
      html: '<p>this is an email message</p>',
      charsets: '{"to":"UTF-8","html":"ISO-8859-1","subject":"UTF-8","from":"UTF-8","text":"ISO-8859-1"}',
      SPF: "pass"
    }
  end

  def normalized_params
    {
      to: ['tb@example.com'],
      from: 'tb@example.com',
      cc: [],
    }
  end
end
