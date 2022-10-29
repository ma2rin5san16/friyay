class RankingsController < ApplicationController

  #1週間のうちにお気に入り登録されたランキング
  def index
    #1週間のうちにお気に入り登録されたランキング
    @weekly_all_rank = Task.find(Favorite.group(:task_id).where(created_at: Time.current.all_week).order('count(task_id) desc').limit(3).pluck(:task_id))

   #全ての期間でお気に入り登録されたランキング
    @all_rank = Task.find(Favorite.group(:task_id).order('count(task_id) desc').limit(3).pluck(:task_id))
  end
end

