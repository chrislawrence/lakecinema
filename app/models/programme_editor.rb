class ProgrammeEditor
  def self.new week
    unless week.holiday?
      week.build_newsletter unless week.newsletter 
      newsletter = week.newsletter
      newsletter.set_content(week.start_date, week.end_date, week.movies)
      newsletter.save
      Thread.new do
        newsletter.send_to_mailchimp
        ActiveRecord::Base.connection.close
      end
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
