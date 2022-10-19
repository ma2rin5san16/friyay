class FavoritesController < ApplicationController

  def toggle_status
    @favorite = Favorite.find(params[:task_id])
    @favorite.toggle_status!
    redirect_to current_user, success: 'ステータスを更新しました'
  end

  def index
    #お気に入りずみのタスクレコードを取得
    @favorite_tasks = current_user.favorite_tasks.order(created_at: :desc)
    @favorites = current_user.favorites
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
