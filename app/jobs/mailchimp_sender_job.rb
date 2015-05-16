class MailchimpSenderJob < ActiveJob::Base
  queue_as :mailchimp

  def perform(newsletter)
    newsletter.send_to_mailchimp
  end
end
