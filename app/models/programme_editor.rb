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

end
