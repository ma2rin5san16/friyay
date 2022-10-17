class FavoritesController < ApplicationController

  def index
    @favorites = current_user.favorite_tasks.order(created_at: :desc)
  end

  def create
    @task = Task.find(params[:task_id])
    @favorite = Favorite.create(user_id: current_user.id, task_id: @task.id)
  end

  def destroy
    @task = Task.find(params[:task_id])
    @favorite = Favorite.find_by(user_id: current_user.id, task_id: @task.id)
      if @favorite.user_id == current_user.id
        @favorite.destroy
      end
  end
end
