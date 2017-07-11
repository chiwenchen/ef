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

  def get_string_between(my_string, start_at, end_at)
    my_string = " #{my_string}"
    ini = my_string.index(start_at)
    return my_string if ini == 0
    ini += start_at.length
    length = my_string.index(end_at, ini).to_i - ini
    my_string[ini,length]
  end
end
