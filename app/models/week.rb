class Week < ActiveRecord::Base
  validates :start_date, presence: true
  validates :end_date, presence: true
  before_save :generate_title

  has_many :movies, dependent: :destroy
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
      self.newsletter.set_content(start_date, movies)
    end
    self.newsletter 
  end

  private

  def generate_title
    if title.nil?
      day = start_date
      new_title = "Weekend "
      while day <= end_date do
        new_title += DateString.new(day, end_date)
        day += 1
      end
    end
    self.title = new_title
  end


end
