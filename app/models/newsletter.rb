class Newsletter < ActiveRecord::Base

  def set_content date, movies = []
    self.send_time = (date - 1.day).to_time + 8 * 60 * 60
    self.body = ""
    movies.map{ |movie| self.body += render(movie) }
  end

  def sent
    true if self.send_time < Time.zone.now
  end

  def send_to_mailchimp
    update_send_time
    sender = Chimp.new(title: self.subject, body: combine_introduction_and_body, campaign_id: self.campaign_id, send_time: self.send_time)
    sender.send
    self.campaign_id = sender.campaign_id
  end

  private

  def render movie
    ApplicationController.new.render_to_string(partial: 'movies/movie', locals: { movie: movie })
  end


  def combine_introduction_and_body
    "Welcome #{markdown(self.introduction)} #{self.body}"
  end

  def update_send_time
    self.send_time = (Time.zone.now + 5.minutes) if self.send_time < Time.zone.now
  end

  def markdown(text)
    renderer = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true)
    renderer.render(text) if text
  end

end
