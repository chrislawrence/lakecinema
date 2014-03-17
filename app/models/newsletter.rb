class Newsletter < ActiveRecord::Base
  before_save :send_to_mailchimp

  def set_content date, movies = []
    self.send_time = (date - 1.day).to_time + 8 * 60 * 60
    self.body = ""
    movies.map{ |movie| self.body += render(movie) }
  end

  def sent
    true if self.send_time < Time.zone.now
  end

  private

  def render movie
    ApplicationController.new.render_to_string(partial: 'movies/movie', locals: { movie: movie })
  end

  def send_to_mailchimp
    update_send_time
    sender = Chimp.new(title: self.subject, body: self.body, campaign_id: self.campaign_id, send_time: self.send_time)
    sender.send
    self.campaign_id = sender.campaign_id
  end

  def update_send_time
    self.send_time = (Time.zone.now + 5.minutes) if self.send_time < Time.zone.now
  end

end
