class RankingController < ApplicationController

    def ranking_index_for_desktop
      @week_task_favorite_ranks = Task.find(Favorite.group(:task_id).where(created_at: Time.current.all_week).order('count(task_id) desc').limit(3).pluck(:task_id))
    end

end
