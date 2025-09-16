class ApplicationController < ActionController::Base
  include Authentication  # make sure this is included

  helper_method :current_user, :user_signed_in?, :require_login, :require_admin

  private

  def current_user
    Current.user
  end

  def user_signed_in?
    current_user.present?
  end

  def require_login
    redirect_to new_session_path, alert: "Please log in first." unless user_signed_in?
  end

  def require_admin
    redirect_to root_path, alert: "Not authorized." unless current_user&.admin?
  end
end
