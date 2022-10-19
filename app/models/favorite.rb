class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :task

  validates_uniqueness_of :task_id, scope: :user_id

  enum status: { unevaluated: 0, evaluated: 1 }

  def toggle_status!
    if unevaluated?
      evaluated!
    else
      unevaluated!
    end
  end
end
