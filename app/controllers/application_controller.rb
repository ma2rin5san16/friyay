class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger
  include SessionsHelper

  private
    def logged_in_user
      unless logged_in?
        redirect_to login_path, warning: "ログインが必要です"
      end
    end

    #ゲストログインの場合はログインが必要
    def only_register_user
      if current_user.guest?
        redirect_to new_user_path, warning: "ユーザー登録が必要な機能です"
      end
    end
end
