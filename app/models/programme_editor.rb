class ProgrammeEditor
  def self.new week
    week.build_newsletter unless week.newsletter
    newsletter = week.newsletter
    newsletter.set_content(week.start_date, week.end_date, week.movies)
    newsletter.save
    #newsletter.send_to_mailchimp
  end

  def self.send_to_mailchimp newsletter
    campaign_id = Chimp.new(
      title: newsletter.id, 
      body: ApplicationController.new.render_to_string('newsletters/show', layout: false, locals: {newsletter: newsletter}),
      campaign_id: newsletter.campaign_id, 
      send_time: newsletter.send_time
    ).send
    newsletter.update_attribute(:campaign_id, campaign_id)


  end

end
