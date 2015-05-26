class NewsletterSender
  @queue = :programme 
  def self.perform(newsletter_id)
    Newsletter.find(newsletter_id).send_to_mailchimp
  end
end
