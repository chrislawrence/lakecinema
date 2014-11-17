class EmailProcessor
  def initialize(email)
    @email = email
  end

  def process
    if Lakecinema::Application.config.admin_emails.include?(@email.from[:email])
      Newsletter.first.update_attribute(:introduction, @email.body)
    end
  end
end
