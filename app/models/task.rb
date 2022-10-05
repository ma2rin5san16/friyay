class Task < ApplicationRecord
  belongs_to :user
  has_many :favorite, dependent: :destroy

  validates :content, presence: true
  validates :easy, presence: true

  enum :easy, [:easy, :normal, :difficult]

end
