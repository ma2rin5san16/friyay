class Place < ApplicationRecord
  has_many :place_tags, dependent: :destroy
  has_many :tasks, through: :place_tags, dependent: :destroy
end
