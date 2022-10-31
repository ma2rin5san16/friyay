module SessionsHelper

  #ログイン処理のメソッド。user.idをsession[:user_id]として暗号化してブラウザに保存
  def log_in(user)
    session[:user_id] = user.id
  end

  #session[:user_id]に値が入っている時、current_userはsession[:user_id]を持つものをログイン中のユーザーとする。
  def current_user
    if session[:user_id]
    @current_user ||= User.find_by(id: session[:user_id])
    end
  end

  #ログインしているユーザーがいればtrue、ログインしていなければfalseを返す。
  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end
