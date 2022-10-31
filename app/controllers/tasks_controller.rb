class TasksController < ApplicationController
  before_action :logged_in_user
  before_action :only_register_user, only: %i[new create destroy edit update]
  before_action :set_q, only: %i[index search]

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
      redirect_to root_path, success: '過ごし方を提案しました'
    else
      flash.now[:danger] = "投稿に失敗しました"
      render :new
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.user == current_user
      @task.update(task_params) 
      redirect_to user_suggested_list_path(current_user), success: "更新しました。"
    else
      flash.now[:danger] = "更新に失敗しました。"
      render 'edit'
    end
  end

  def destroy
    task = Task.find(params[:id])
    if task.user == current_user
      task.destroy
      redirect_to user_suggested_list_path(current_user), success: "削除しました。"
    else
      flash.now[:danger] = "無効な権限です"
      root_path
    end
  end

  def random_show
    @task = Task.order("RANDOM()").first
    @favorite = Favorite.find_by(user_id: current_user.id, task_id: @task.id)
    @favorites= @task.favorites.order(created_at: :desc).page(params[:page])
  end

  private

    def task_params
      params.require(:task).permit(:content, :prepare, :easy)
    end

    def set_q
      @q = Task.ransack(params[:q])
    end
end
