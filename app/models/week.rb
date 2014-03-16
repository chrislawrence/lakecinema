class Week < ActiveRecord::Base
  validates :start_date, presence: true
  validates :end_date, presence: true
  before_save :generate_title

  has_many :movies, dependent: :destroy
  accepts_nested_attributes_for :movies

  has_one :holiday, dependent: :destroy
  accepts_nested_attributes_for :holiday, reject_if: :all_blank

  def nested_partial_path
    if self.holiday
      'weeks/week_with_holidays' 
    else
      'weeks/week_with_movies'
    end
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
