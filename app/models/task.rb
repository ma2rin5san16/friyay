class Task < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :content, presence: true
  validates :easy, presence: true

  enum :easy, [:easy, :normal, :difficult]

end
