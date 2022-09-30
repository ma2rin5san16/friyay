class UsersController < ApplicationController
  def index
  end

  def new
    @user = User.new

  end

  def show
    @user = current_user
    ＠tasks = @user.tasks
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to users_path
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :birthday, :gender, :password, :password_confirmation)
  end
end
