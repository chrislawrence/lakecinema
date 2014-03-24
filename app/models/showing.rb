class Showing < ActiveRecord::Base
  belongs_to :movie, touch: true
end
