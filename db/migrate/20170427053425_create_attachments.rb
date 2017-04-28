class CreateAttachments < ActiveRecord::Migration
  def change
    enable_extension 'uuid-ossp'
    create_table :attachments, id: :uuid do |t|
      t.string :file
      t.uuid :service_request_id
      t.timestamps null: false
    end
  end
end
