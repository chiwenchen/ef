class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.uuid :service_request_id
      t.uuid :user_id
      t.text :body
      t.timestamps null: false
    end
  end
end
