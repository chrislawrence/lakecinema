class Newsletter < ActiveRecord::Base
  before_save :send_to_mailchimp

  def set_content date, movies = []
    self.send_time = (date - 1.day).to_time + 8 * 60 * 60
    self.body = ""
    movies.inject { |movie| self.body += render(movie) }
  end

  private

  def render movie
    ApplicationController.new.render_to_string(
      partial: 'movies/movie',
      locals: { :movie => movie }
    )
  end

  def send_to_mailchimp
    self.campaign_id = MailchimpCampaign.send(campaign_id)
  end
end
