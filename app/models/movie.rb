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
    url: "/assets/posters/:id/:style/:basename.:extension",
    path: ":rails_root/public/assets/posters/:id/:style/:basename.:extension",
    default_url: ActionController::Base.helpers.asset_path('missing.png')
  validates_attachment_content_type :poster, content_type: ["image/jpg", "image/jpeg", "image/png"]
  before_save :download_poster
  before_save :reject_showings
  after_initialize :build_showings

  def tmdb_url
    "http://themoviedb.org/movie/#{self.tmdb_id}"
  end

  def backdrop_url
    "http://image.tmdb.org/t/p/w780#{backdrop}"
  end

  private

  def build_showings
    if self.showings.count == 0
      self.showings.build(day: 'Friday')
      self.showings.build(day: 'Saturday')
      self.showings.build(day: 'Sunday')
    end
  end

  def reject_showings
    self.showings.each do |s|
      s.delete if s.times.blank?
    end

  end

  def download_poster
    save_poster_from_url(self.poster_url) if self.poster_url_changed? && !self.poster_url.blank?
  end

  def save_poster_from_url url
    self.poster = URI.parse(url)
  end

end
