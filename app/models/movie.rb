class Movie < ActiveRecord::Base
  belongs_to :week, touch: true
  has_many :showings, -> { order "view_index ASC"}, dependent: :destroy
  accepts_nested_attributes_for :showings, reject_if: proc {|a| a['times'].blank?}
  has_attached_file :poster, styles: {
    normal: ["200x296#", :jpg],
    retina: ["400x592#", :jpg]
    },
    url: "/assets/posters/:id/:style/:basename.:extension",
    path: ":rails_root/public/assets/posters/:id/:style/:basename.:extension",
    default_url: '/assets/posters/missing.jpg'
  validates_attachment_content_type :poster, content_type: ["image/jpg", "image/jpeg", "image/png"]
  before_save :get_metadata

  def tmdb_url
    "http://themoviedb.org/movie/#{self.tmdb_id}"
  end

  def backdrop_url
    "http://image.tmdb.org/t/p/w780#{backdrop}"
  end


  private

  def get_metadata
    if tmdb_id
      @search = Search.movie_by_id(self.tmdb_id)
      download_poster
      self.backdrop ||= @search.backdrop_path
      self.director ||= @search.director
      self.cast ||= @search.cast
    end
  end

  def download_poster
    save_poster_from_url(self.poster_url) if self.poster_url_changed? && !self.poster_url.blank?
  end

  def save_poster_from_url url
    self.poster = URI.parse(url)
  end

end
