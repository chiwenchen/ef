class CreateAssignments < ActiveRecord::Migration
  def change
    enable_extension 'uuid-ossp'
    create_table :assignments, id: :uuid do |t|
      t.uuid :service_request_id
      t.uuid :user_id
      t.timestamps null: false
    end
  end
end
