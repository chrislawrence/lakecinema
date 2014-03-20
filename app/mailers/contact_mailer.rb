class ContactMailer < ActionMailer::Base
  def new_message(message, to)
    @message = message
    mail(subject: "New message: Lake Cinema contact form", from: message.email, to: to)
  end
end
