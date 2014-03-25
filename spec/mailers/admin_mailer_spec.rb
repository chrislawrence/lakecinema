require 'spec_helper'

describe AdminMailer do
  it 'links to the edit newsletter path' do
    week = create(:week)
    mail = AdminMailer.newsletter_reminder(week)
    expect(mail.body).to include("http://admin.lakecinema.net.au/newsletters/#{week.id}/edit")
  end

  it 'includes the movie titles in the email' do
    week = create(:week_with_movies_and_showings)
    mail = AdminMailer.newsletter_reminder(week)
    expect(mail.body).to include("The Godfather")
  end
end
