class HomeController < ApplicationController
  def landing
    redirect_if_has_role if current_user
  end

  def set_locale
    if params[:languages][:locale] && I18n.available_locales.include?( params[:languages][:locale].to_sym )
      session[:locale] = params[:languages][:locale]
    end
    redirect_to :back
  end

  private

  def redirect_if_has_role
    if current_user.admin?
      redirect_to admin_root_path
    elsif current_user.tech? || current_user.sales?
      redirect_to staff_root_path
    elsif current_user.customer?
      redirect_to customer_root_path
    end
  end
end