class RankingsController < ApplicationController
  before_action :logged_in_user

  def index

    @tasks = Task.find(Favorite.group_by_task.order('count(task_id) desc').limit(3).pluck(:task_id))

    @range = params[:range]
    @gender = params[:gender]
    @generate = params[:gender]

    if @range == "1" && @gender == "1"
      @tasks = Task.find(Favorite.with_user.search_with_gender(0).group_by_task.order('count(task_id) desc').limit(3).pluck(:task_id))
    elsif @range == "1" && @gender == "2"
      @tasks = Task.find(Favorite.with_user.search_with_gender(1).group_by_task.order('count(task_id) desc').limit(3).pluck(:task_id)) 
    elsif @range == "2" && @gender == "1"
      @tasks = Task.find(Favorite.with_user.search_with_gender(0).search_with_weekly.group_by_task.order('count(task_id) desc').limit(3).pluck(:task_id))
    elsif @range == "2" && @gender == "2"
      @tasks = Task.find(Favorite.with_user.search_with_gender(1).search_with_weekly.group_by_task.order('count(task_id) desc').limit(3).pluck(:task_id))
    elsif @range == "1"
      @tasks = Task.find(Favorite.group_by_task.order('count(task_id) desc').limit(3).pluck(:task_id))
    elsif @range == "2"
      @tasks = Task.find(Favorite.group_by_task.search_with_weekly.order('count(task_id) desc').limit(3).pluck(:task_id))
    end

    @favorite = Favorite.find_by(user_id: current_user.id)
  end
end
