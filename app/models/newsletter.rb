class Newsletter < ActiveRecord::Base
  belongs_to :week
  default_scope { order(:start_date) }

  def set_content start_date, end_date, movies = []
    self.send_time = (start_date.to_time - 1.day) + 8.hours
    self.start_date = start_date
    self.end_date = end_date
  end

  def movies
    self.week.movies
  end

  def sent
    true if self.send_time < Time.zone.now
  end

  def send_date
    send_time.to_date
  end

  def dates
    start_date.strftime("%B %-d") + "&mdash;" + end_date.strftime("%B %-d")
  end

  def body
    ApplicationController.new.render_to_string('newsletters/show', layout: false, locals: { newsletter: self })
  end

  def send_to_mailchimp
    sender = Chimp.new(title: self.subject, body: self.body, campaign_id: self.campaign_id, send_time: self.send_time)
    sender.send
    self.update(campaign_id: sender.campaign_id)
  end

  private

  def render movie
    ApplicationController.new.render_to_string(partial: 'movies/movie', locals: { movie: movie, newsletter: true })
  end


  def combine_introduction_and_body
    "#{markdown(self.introduction)} #{self.body}"
  end

  def markdown(text)
    renderer = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true)
    renderer.render(text) if text
  end

end
