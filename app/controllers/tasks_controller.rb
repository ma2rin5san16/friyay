class TasksController < ApplicationController
  before_action :logged_in_user
  before_action :only_register_user, only: %i[new create destroy edit update]
  before_action :set_q, only: %i[index search]
  before_action :set_task, only: %i[edit update destroy]

  def index
    @tasks = @q.result.order(created_at: :desc).page(params[:page])
    @favorite = Favorite.find_by(user_id: current_user.id)
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id
    if @task.save
      redirect_to new_task_path, success: '過ごし方を提案しました'
    else
      flash.now[:danger] = "投稿に失敗しました"
      render :new
    end
  end

  def edit; end

  def update
    if @task.user == current_user
      @task.update(task_params) 
      redirect_to suggested_list_path, success: "更新しました。"
    else
      flash.now[:danger] = "更新に失敗しました。"
      render 'edit'
    end
  end

  def destroy
    if task.user == current_user
      task.destroy
      redirect_to user_suggested_list_path(current_user), success: "削除しました。"
    else
      flash.now[:danger] = "無効な権限です"
      root_path
    end
  end

  def random_show
    @tasks = Task.all
    @task = @tasks.shuffle.first
    @favorite = Favorite.find_by(user_id: current_user.id, task_id: @task.id)
    @favorites= @task.favorites.order(created_at: :desc).page(params[:page])
  end

  private

    def task_params
      params.require(:task).permit(:content, :prepare, :easy, place_ids: [])
    end

    def set_q
      @q = Task.ransack(params[:q])
    end

    def set_task
      @task = Task.find(params[:id])
    end
end
