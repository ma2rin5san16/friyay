class GuestSessionsController < ApplicationController

  def new; end

  def create
    user = User.new(user_params)
      user.name = "ゲスト"
      user.email = "guest_#{SecureRandom.urlsafe_base64}@example.com"
      user.password = SecureRandom.urlsafe_base64
      user.password_confirmation = user.password
      user.guest = true
    if user.save
      log_in user
      redirect_to root_path, success: 'ゲストとしてログインしました'
    else
      flash.now[:danger] = "ログインできませんでした"
      render 'new'
    end
  end

  private
    def user_params
      params.permit(:birthday, :gender)
    end
end
