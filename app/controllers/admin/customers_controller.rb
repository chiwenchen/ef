class Admin::CustomersController < AdminController

  def index
    @customers = User.customers
  end

  def responsible_table
    @customers = User.customers
  end
end