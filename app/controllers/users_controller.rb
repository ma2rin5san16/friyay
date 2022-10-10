class UsersController < ApplicationController
  def index
  end

  def new
    @user = User.new
  end

  def show
    @user = current_user
    ＠tasks = @user.tasks

    favorites = Favorite.where(user_id: current_user.id).pluck(:task_id)
    @favorite_list = Task.find(favorites)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path, success: "ユーザーを登録しました"
    else
      flash.now[:danger] = "登録に失敗しました"
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
