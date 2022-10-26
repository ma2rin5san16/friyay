class UsersController < ApplicationController

  def index
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path, success: "ユーザーを登録しました"
    else
      binding.pry
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

  def suggested_list
    @user = User.find(params[:user_id])
  end

  def favorited_list
    @user = User.find(params[:user_id])
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :birthday, :gender, :password, :password_confirmation)
  end
end
