class AddLineUserIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :line_user_id, :string
  end
end
