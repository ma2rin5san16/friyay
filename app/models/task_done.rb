class TaskDone < ApplicationRecord
  belongs_to :user
  belongs_to :task

  validates :comment, presence: true
  validates :rating, presence: true
end
