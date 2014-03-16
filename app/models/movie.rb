class Movie < ActiveRecord::Base
  belongs_to :week, touch: true
  has_many :showings
  accepts_nested_attributes_for :showings, reject_if: proc {|a| a['times'].blank?}
end
