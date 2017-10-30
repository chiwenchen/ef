class AddJobNumberToUser < ActiveRecord::Migration
  def change
    add_column :users, :staff_number, :string
    add_column :users, :customer_number, :string
  end
end
