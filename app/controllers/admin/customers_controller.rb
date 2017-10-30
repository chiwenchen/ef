class Admin::CustomersController < AdminController

  def index
    @customers = User.customers.page(params[:page]).per(10)
  end

  def responsible_table
    @customers = User.customers.order('created_at DESC')
  end
end