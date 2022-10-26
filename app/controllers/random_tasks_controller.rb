class RandomTasksController  ApplicationController
  before_action :set_favorite

  def show
    @task = Task.order("RAND()").first
  end

  def set_favorite
    @favorite = Favorite.find_by(user_id: current_user.id, task_id: @task.id)
  end
end
