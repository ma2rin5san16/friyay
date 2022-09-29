class Task < ApplicationRecord
  belongs_to :user

  validates :content, presence: true
  validates :easy, presence: true
end
