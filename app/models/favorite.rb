class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :task

  validates :comment, length: { maximum: 255}
  validates :rating, numericality: { only_integer: true,
                                     allow_nil: true,
                                     greater_than_or_equal_to: 1,
                                     less_than_or_equal_to: 5
                                    }

  #statusが未達成の時、コメントと評価ができないバリデーション
  validates :comment, :rating, absence: true, if: -> { unevaluated? }

  validates_uniqueness_of :task_id, scope: :user_id

  enum status: { unevaluated: 0, evaluated: 1 }

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

  #statusがunevaluatedになったらcommentとratingがnilになるインスタンスメソッド
end
