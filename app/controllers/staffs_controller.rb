class StaffsController < UsersController
  layout 'staff'
  before_action :must_be_staff

  def index

  end

  private

  def must_be_staff
    unless current_user && ( current_user.sales? || current_user.tech? )
      flash[:notice] = '你必須有員工授權才可以進行此操作喔'
      redirect_to root_path
    end
  end
end