class ContactMailer < ActionMailer::Base
  def cinema(message)
    @message = message
    mail(subject: "New message: Lake Cinema contact form", from: message.email, to: 'enquiries@lakecinema.net.au')
  end
end
