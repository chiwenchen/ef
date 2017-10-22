class Admin::StaffsController < AdminController

  def admin_index
    @admins = User.admins.page(params[:page]).per(10)
  end

  def sales_index
    @sales = User.sales.page(params[:page]).per(10)
  end

  def techs_index
    @teches = User.teches.page(params[:page]).per(10)
  end
end