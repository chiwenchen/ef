class Admin::StaffsController < AdminController

  def admin_index
    @admins = User.admins
  end

  def sales_index
    @sales = User.sales
  end

  def techs_index
    @teches = User.teches
  end
end