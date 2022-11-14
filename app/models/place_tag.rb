class PlaceTag < ApplicationRecord
  belongs_to :task
  belongs_to :place
end
