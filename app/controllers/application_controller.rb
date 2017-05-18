class ApplicationController < ActionController::Base
  include Pundit

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_action :store_current_location, if: :should_store_location?

  helper_method :current_profile

  def after_sign_in_path_for(resource)
    if request.referer && request.referer.ends_with?(new_user_registration_path)
      user_start_path
    else
      request.env['omniauth.origin'] || stored_location_for(resource) || user_start_path
    end
  end

  protected

  def store_current_location
    store_location_for(:user, request.url) if request.get?
  end

  def should_store_location?
    request.get? &&
      !devise_controller? &&
      !controller_name == 'subscriptions'
  end

  def user_start_path
    if request.referer && request.referer.ends_with?(new_user_registration_path)
      user_path(current_user)
    else
      current_user_admin? ? dashboard_path : user_path(current_user)
    end
  end

  def access_denied
    redirect_to root_url, notice: t('.notice')
  end

  def require_admin
    current_user_admin? || access_denied
  end

  def current_user_admin?
    user_signed_in? && current_user.role?('admin')
  end

  def user_not_authorized
    flash[:alert] = t('.user_not_authorized')
    redirect_to(request.referer || root_path)
  end

  def current_profile
    current_user.profile
  end
end
