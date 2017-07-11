class AddOwnerSalesTechIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :owner_id, :uuid
    add_column :users, :sales_id, :uuid
    add_column :users, :tech_id, :uuid
  end
end
