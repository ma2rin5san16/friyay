class TasksController < ApplicationController
  before_action :logged_in_user, only:[:new, :create, :destroy, :index]
  before_action :only_register_user, only:[:new, :create, :destroy]
  before_action :set_q, only:[:index, :search]

  def index
    @tasks = @q.result.order(created_at: :desc).page(params[:page])
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

  def show
    @task = Task.find(params[:id])
    @user = User.find_by(id: @task.user_id)
  end

  def edit
  end

  def search
    @results = @q.result
  end

  def random_show
    @task = Task.order("RAND()").first
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
