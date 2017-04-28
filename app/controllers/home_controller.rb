class HomeController < ApplicationController
  def landing
    redirect_if_has_role if current_user
  end

  private

  def redirect_if_has_role
    if current_user.admin?
      redirect_to admin_root_path
    elsif current_user.tech? || current_user.sales?
      redirect_to staffs_path
    elsif current_user.customer?
      redirect_to customer_root_path
    end
  end
end