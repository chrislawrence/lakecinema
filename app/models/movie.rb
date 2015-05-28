class Movie < ActiveRecord::Base
  belongs_to :week, touch: true
  belongs_to :newsletter 
  has_many :showings,-> {order(position: :asc) }, dependent: :destroy
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
  before_save :reject_showings

  def tmdb_url
    "http://themoviedb.org/movie/#{self.tmdb_id}"
  end

  def build_showings
    if self.showings.count == 0
      self.showings.build(day: 'Friday', position: 0)
      self.showings.build(day: 'Saturday', position: 1)
      self.showings.build(day: 'Sunday', position: 2)
    end
  end

  def self.default
    Movie.new(showings: [Showing.new(day: 'Friday'), Showing.new(day: 'Saturday'), Showing.new(day: 'Sunday')])
  end

  def download_images_later
    Resque.enqueue(PosterDownloader,self.id)
  end

  def download_images
    begin
      self.poster = parse_image(self.poster_url) 
    rescue => error
      Rails.logger.debug("Poster failed to save, #{error}")
    end

    begin
      self.backdrop = parse_image(self.backdrop_url) 
    rescue => error
      Rails.logger.debug("Backdrop failed to save, #{error}")
    end

    self.save
  end

  def cast=(actors)
    actors = actors.gsub(/\"|\{|\}|\\/, "")
    write_attribute(:cast, actors.split(','))
  end

  private

  def parse_image url
    URI.parse(url) unless url.blank?
  end

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

end
