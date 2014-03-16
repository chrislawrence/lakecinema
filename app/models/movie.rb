class Movie < ActiveRecord::Base
  belongs_to :week
  has_many :showings
end
