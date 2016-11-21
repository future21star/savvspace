class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    # request.env['omniauth.origin'] || stored_location_for(resource) || root_path
    request.env['omniauth.origin'] || dashboard_path
  end

  protected

  def access_denied
    redirect_to root_url, notice: "Access denied"
  end

  def require_admin
    user_signed_in? && current_user.has_role?("admin") || access_denied
  end
end
