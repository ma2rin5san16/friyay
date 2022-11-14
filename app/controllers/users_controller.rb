class UsersController < ApplicationController
  before_action :only_register_user, only: %i[edit update suggested_list]
  before_action :logged_in_user, except: %i[new create]

  def new
    @user = User.new
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

  def suggested_list
    @user = User.find(current_user.id)
    @tasks = @user.tasks.order(created_at: :desc).page(params[:page])
    @favorite = Favorite.find_by(user_id: current_user.id)
  end

  def favorited_list
    @user = User.find(current_user.id)
    @favorites = @user.favorites.order(created_at: :desc).page(params[:page])
    @favorite = Favorite.find_by(user_id: current_user.id)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :birthday, :gender, :password, :password_confirmation)
  end
end
