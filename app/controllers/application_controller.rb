class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :setting_locale

  def after_sign_in_path_for(resource)
    if resource.admin?
      admin_root_path
    else
      request.env['omniauth.origin'] || landing_home_index_path
    end
  end

  def setting_locale
    I18n.locale = session[:locale] || I18n.default_locale
  end
end
