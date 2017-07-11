class CreateImages < ActiveRecord::Migration
  def change
    enable_extension 'uuid-ossp'
    create_table :images, id: :uuid do |t|
      t.string :file_path
      t.uuid :service_request_id
      t.timestamps null: false
    end
  end
end
