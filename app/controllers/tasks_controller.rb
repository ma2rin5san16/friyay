class TasksController < ApplicationController
  before_action :logged_in_user, only:[:new, :create, :destroy]

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id
    if @task.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @task = Task.find(params[:id])
    @user = User.find_by(id: @task.user_id)
  end

  def index
  end

  def edit
  end

  private
    def task_params
      params.require(:task).permit(:content, :prepare, :easy)
    end
end
