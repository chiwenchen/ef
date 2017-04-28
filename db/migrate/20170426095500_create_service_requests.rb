class CreateServiceRequests < ActiveRecord::Migration
  def change
    enable_extension 'uuid-ossp'
    create_table :service_requests, id: :uuid do |t|
      t.string :request_id
      t.string :title
      t.uuid :customer_id
      t.uuid :category_id
      t.text :description
      t.date :deadline
      t.timestamps null: false
    end
  end
end
