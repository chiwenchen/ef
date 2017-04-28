class AddStateToServiceRequests < ActiveRecord::Migration
  def change
    add_column :service_requests, :state, :string
  end
end
