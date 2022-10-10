class ApplicationController < ActionController::Base
  include SessionsHelper
  add_flash_types :success, :info, :warning, :danger

  private
    def logged_in_user
      unless logged_in?
        redirect_to login_path
      end
    end
end
