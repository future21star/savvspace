class ApplicationController < ActionController::Base
  include Pundit

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || stored_location_for(resource) || user_start_path
  end

  protected

  def user_start_path
    if request.referrer.ends_with?(new_user_registration_path)
      user_path(current_user)
    else
      current_user_admin? ? dashboard_path : user_path(current_user)
    end
  end

  def access_denied
    redirect_to root_url, notice: "Access denied"
  end

  def require_admin
    current_user_admin? || access_denied
  end

  def current_user_admin?
    user_signed_in? && current_user.has_role?("admin")
  end
end
