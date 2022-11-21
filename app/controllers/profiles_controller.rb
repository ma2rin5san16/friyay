class ProfilesController < ApplicationController
  before_action :set_user
  before_action :only_register_user, except: %i[show]

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to profile_path, success: "登録内容を編集しました"
    else
      flash.now[:danger] = "登録に失敗しました"
      render :edit
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :birthday, :gender, :password, :password_confirmation)
    end

    def set_user
      @user = User.find(current_user.id)
    end
end
