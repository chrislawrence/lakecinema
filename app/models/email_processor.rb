class EmailProcessor
  def initialize(email)
    @email = email
  end

  def process
    if Lakecinema::Application.config.admin_emails.include?(@email.from[:email])
      newsletter = Newsletter.first
      newsletter.update_attribute(:introduction, @email.body)
      newsletter.send_to_mailchimp
    end
  end
end
