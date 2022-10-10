class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to root_path, success: "ログインしました"
    else
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path, success: "ログアウトしました"
  end
end
