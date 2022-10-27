class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger
  include SessionsHelper

  private
    def logged_in_user
      unless logged_in?
        redirect_to login_path
      end
    end

    #ゲストログインの場合はログインが必要
    def only_register_user
      if current_user.guest?
        redirect_back_or_to root_path, warning: "無効な権限です"
      end
    end
end
