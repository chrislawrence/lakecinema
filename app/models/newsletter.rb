class Newsletter < ActiveRecord::Base
  belongs_to :week
  has_many :movies, dependent: :destroy
  accepts_nested_attributes_for :movies
  default_scope { order(:start_date) }
  before_destroy :remove_from_mailchimp

  def set_content start_date = self.week.start_date, end_date = self.week.end_date, movies = self.week.movies
    self.send_date = start_date - 1.day
    self.start_date = start_date
    self.end_date = end_date
    self.movies << movies
  end

  def sent
    true if self.send_time < Time.zone.now
  end

  def dates
    if start_date
      start_date.strftime("%B %-d") + "&mdash;" + end_date.strftime("%B %-d")
    end
  end

  def sendable
    ApplicationController.new.render_to_string('newsletters/show', layout: false, locals: { newsletter: self })
  end

  def send_time
    if Date.today < send_date
      send_date.to_datetime + 8.hours
    else
      5.minutes.from_now
    end
  end

  def send_to_mailchimp
    sender = Chimp.new(title: self.subject, body: self.sendable, campaign_id: self.campaign_id, send_time: self.send_time)
    sender.send
    self.update(campaign_id: sender.campaign_id)
  end

  def remove_from_mailchimp
    begin
      Chimp.new(campaign_id: self.campaign_id).delete
    rescue
      return
    end
  end
end
