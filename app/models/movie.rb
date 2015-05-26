class Movie < ActiveRecord::Base
  belongs_to :week, touch: true
  belongs_to :newsletter 
  has_many :showings, dependent: :destroy
  accepts_nested_attributes_for :showings, reject_if: proc {|a| a['times'].blank?}, allow_destroy: true
  has_attached_file :poster, 
    styles: {
      normal: ["200x296#", :jpg],
      retina: ["400x592#", :jpg]
    },
    default_url: ':placeholder'
  has_attached_file :backdrop,
    styles: { normal: ['650x', :jpg] }
  validates_attachment_content_type :poster, content_type: ["image/jpg", "image/jpeg", "image/png"]
  before_save :download_images
  before_save :reject_showings

  def tmdb_url
    "http://themoviedb.org/movie/#{self.tmdb_id}"
  end

  def build_showings
    if self.showings.count == 0
      self.showings.build(day: 'Friday')
      self.showings.build(day: 'Saturday')
      self.showings.build(day: 'Sunday')
    end
  end

  def self.default
    Movie.new(showings: [Showing.new(day: 'Friday'), Showing.new(day: 'Saturday'), Showing.new(day: 'Sunday')])
  end

  def download_images
    Rails.logger.debug("Processing posters in background...")
    save_poster_from_url(self.poster_url) if self.poster_url_changed? && !self.poster_url.blank?
    save_backdrop_from_url(self.backdrop_url) if self.backdrop_url_changed? && !self.backdrop_url.blank?
  end

  private

  def reject_showings
    self.showings.each do |s|
      s.delete if s.times.blank?
    end

  end

  def save_poster_from_url url
    self.poster = URI.parse(url)
  end
  
  def save_backdrop_from_url url
    self.backdrop = URI.parse(url)
  end

  def schedule_images
    Rails.logger.debug("Downloading posters for movie #{self.id}")
    Resque.enqueue(PosterDownloader, self.id)
  end

end
