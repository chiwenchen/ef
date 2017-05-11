class CreateComments < ActiveRecord::Migration
  def change
    enable_extension 'uuid-ossp'
    create_table :comments, id: :uuid do |t|
      t.uuid :service_request_id
      t.uuid :user_id
      t.text :body
      t.timestamps null: false
    end
  end
end
