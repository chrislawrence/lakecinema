class Showing < ActiveRecord::Base
  belongs_to :movie, touch: true
  default_scope { order('position') }
end
