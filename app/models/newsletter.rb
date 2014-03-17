class Newsletter < ActiveRecord::Base
  before_save :send_to_mailchimp

  def set_content date, movies = []
    self.send_time = (date - 1.day).to_time + 8 * 60 * 60
    self.body = ""
    movies.map{ |movie| self.body += render(movie) }
  end

  private

  def render movie
    ApplicationController.new.render_to_string(partial: 'movies/movie', locals: { movie: movie })
  end

  def send_to_mailchimp
    sender = Chimp.new(title: self.subject, body: self.body, campaign_id: self.campaign_id)
    sender.send
    update_attributes(campaign_id: sender.campaign_id, sent: sender.sent)
  end
end
