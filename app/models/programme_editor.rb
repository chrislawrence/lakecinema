class ProgrammeEditor
  def self.new week
    unless week.holiday?
      week.movies.each do |m|
        m.download_images_later
      end
      week.build_newsletter unless week.newsletter 
      newsletter = week.newsletter
      newsletter.set_content(week.start_date, week.end_date, week.movies)
      newsletter.save
      Resque.enqueue(NewsletterSender, newsletter.id)
    end
  end

  def self.send_to_mailchimp newsletter
    Rails.logger.debug('Sending to mailchimp...')
    campaign_id = Chimp.new(
      title: newsletter.id, 
      body: ApplicationController.new.render_to_string('newsletters/show', layout: false, locals: {newsletter: newsletter}),
      campaign_id: newsletter.campaign_id, 
      send_time: newsletter.send_time
    ).send
    newsletter.update_attribute(:campaign_id, campaign_id)


  end

end
