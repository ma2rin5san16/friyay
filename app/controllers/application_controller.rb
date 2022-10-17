class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger
  include SessionsHelper

  private
    def logged_in_user
      unless logged_in?
        redirect_to login_path
      end
    end

    def register_user
      if current_user.guest?
        redirect_to login_path
      end
    end
end
