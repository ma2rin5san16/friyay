class FavoritesController < ApplicationController
  before_action :set_post, only: [:create, :destroy]

  def index
    @tasks = current_user.favorite
  end

  def create
    @favorite = Favorite.create(user_id: current_user.id, task_id: @task.id)
  end

  def destroy
    @favorite = Favorite.find_by(user_id = current_user.id, task_id = @task.id)
      if @favorite.user_id == current_user.id
        @favorite.destroy
      end
  end

  private
    def set_task
      @task = Task.find(params[:id])
    end
end
