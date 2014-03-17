class Movie < ActiveRecord::Base
  belongs_to :week, touch: true
  has_many :showings, -> { order "view_index ASC"} 
  accepts_nested_attributes_for :showings, reject_if: proc {|a| a['times'].blank?}
  has_attached_file :poster, styles: {
    :poster => ["200x296#", :jpg],
    :'poster@2x' => ["400x592#", :jpg]
    },
    url: "/assets/photos/:id/:style/:basename.:extension",
    path: ":rails_root/public/assets/photos/:id/:style/:basename.:extension"
  before_save :download_poster

  private

  def download_poster
    if !self.poster_url.blank?
      self.poster = URI.parse(self.poster_url)
    end
  end

end
