class Admin::CustomersController < AdminController

  def index
    @customers = User.customers
  end

  def responsible_table
    @customers = User.customers.order('created_at DESC')
  end
end