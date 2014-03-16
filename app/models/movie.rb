class Movie < ActiveRecord::Base
  belongs_to :week, touch: true
  has_many :showings, -> { order "view_index ASC"} 
  accepts_nested_attributes_for :showings, reject_if: proc {|a| a['times'].blank?}
end
