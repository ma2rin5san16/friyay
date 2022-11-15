class Task < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :place_tags, dependent: :destroy
  has_many :places, through: :place_tags, dependent: :destroy
  has_many :task_categories, dependent: :destroy
  has_many :categories, through: :task_categories, dependent: :destroy

  validates :content, presence: true
  validates :easy, presence: true

  enum :easy, [:easy, :normal, :difficult]

end
