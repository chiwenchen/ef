class Admin::CustomersController < AdminController

  def index
    @customers = User.customers
  end
end