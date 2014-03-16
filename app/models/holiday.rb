class Holiday < ActiveRecord::Base
  belongs_to :week, touch: true
end
