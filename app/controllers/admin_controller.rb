class AdminController < UsersController
  layout 'admin'
  before_action :must_be_admin

  def index

  end

  private

  def must_be_admin
    if not current_user && current_user.admin?
      flash[:notice] = '你必須是管理員才可以進行此操作喔'
      redirect_to root_path
    end
  end
end