class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :task

  validates :comment, length: { maximum: 255 }
  validates :rating, numericality: { only_integer: true,
                                     allow_nil: true,
                                     greater_than_or_equal_to: 1,
                                     less_than_or_equal_to: 5
                                    }

  #statusがunevaluatedの時、コメントと評価ができないバリデーション
  validates :comment, :rating, absence: true, if: -> { unevaluated? }

  validates_uniqueness_of :task_id, scope: :user_id

  enum status: { unevaluated: 0, evaluated: 1 }


  #ランキングで使用
  scope :with_user, -> { joins(:user) }
  scope :search_with_gender, ->(gender) { where(users: {gender: gender}) }
  scope :group_by_task, -> { group(:task_id) }
  scope :search_with_weekly, -> { where(created_at: Time.current.all_week) }
  scope :birth_between, -> (from, to) { where(users: { birthday: from..to }) }

  #ステータスを未実行⇄実行済に変更
  def toggle_status!
    if unevaluated?
      evaluated!
    else
      self.comment = nil
      self.rating = nil
      unevaluated!
    end
  end
end
