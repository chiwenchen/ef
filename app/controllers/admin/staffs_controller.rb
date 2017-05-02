class Admin::StaffsController < AdminController

  def index
    @admins = User.admins
    @sales = User.sales
    @teches = User.teches
  end
end