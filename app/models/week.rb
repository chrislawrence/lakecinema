class Week < ActiveRecord::Base
  default_scope { order(:start_date) }
  validates :start_date, presence: true
  validates :end_date, presence: true
  before_save :generate_title

  has_many :movies, -> {order "view_index ASC"}, dependent: :destroy
  accepts_nested_attributes_for :movies, reject_if: proc {|a| a['title'].blank?}

  has_one :holiday, dependent: :destroy
  accepts_nested_attributes_for :holiday, reject_if: :all_blank

  has_one :newsletter, dependent: :destroy

  def nested_partial_path
    if self.holiday
      'weeks/week_with_holidays' 
    else
      'weeks/week_with_movies'
    end
  end

  def get_or_build_newsletter 
    if !self.newsletter
      self.build_newsletter
    end
    self.newsletter.set_content(start_date, end_date, movies)
    self.save
    self.newsletter 
  end

  def movie_titles
    self.movies.pluck(:title).join(" & ")
  end

  def self.remove_old_weeks
    Week.where('end_date <= ?', Date.today).destroy_all
  end

  def self.remind_to_write_newsletter
    if !Week.first.newsletter || !Week.first.newsletter.introduction
      AdminMailer.newsletter_reminder(Week.first)
    end
  end

  def standard?
    self.category == 'standard' ? true : false
  end

  def holiday?
    self.category == 'holiday' ? true : false
  end

  def announcement?
    self.category == 'announcement' ? true : false
  end

  private

  def generate_title
    if title.blank?
      if self.holiday
        self.title = 'School Holiday Programme'
      else
        day = start_date
        new_title = "Weekend "
        while day <= end_date do
          new_title += DateString.new(day, end_date)
          day += 1
        end
        self.title = new_title
      end
    end
  end

end
