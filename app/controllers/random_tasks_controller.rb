class RandomTasksController < ApplicationController
  def show
    @task = Task.order("RAND()").first
    @favorited = Favorite.find_by(user_id: current_user.id, task_id: @task.id)
  end
end
