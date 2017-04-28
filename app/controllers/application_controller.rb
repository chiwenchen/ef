class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    if resource.admin?
      admin_index_path
    else
      request.env['omniauth.origin'] || landing_home_index_path
    end
  end
end
