class CustomersController < UsersController
  layout 'customer'
  before_action :must_be_customer

  def index

  end

  private

  def must_be_customer
    if not current_user && current_user.customer?
      flash[:notice] = '你必須是客戶才可以進行此操作喔'
      redirect_to root_path
    end
  end
end