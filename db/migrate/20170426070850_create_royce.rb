class CreateRoyce < ActiveRecord::Migration

  def change
    enable_extension 'uuid-ossp'
    create_table :royce_role, id: :uuid do |t|
      t.string :name, null: false
      t.timestamps
    end

    create_table :royce_connector, id: :uuid do |t|
      t.uuid :roleable_id, null: false
      t.string :roleable_type, null: false
      t.uuid :role_id, null: false
      t.timestamps
    end

    add_index :royce_connector, [:roleable_id, :roleable_type]
    add_index :royce_connector, :role_id

    add_index :royce_role, :name

  end
end