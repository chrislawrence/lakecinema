class AdminMailer < ActionMailer::Base
  def newsletter_reminder week
    @url = "http://admin.lakecinema.net.au/newsletters/#{week.id}/edit"
    @week = week
    mail(subject: 'Reminder to write the Lake Cinema newsletter', to: 'c@chrislawrence.co')  
  end
end
