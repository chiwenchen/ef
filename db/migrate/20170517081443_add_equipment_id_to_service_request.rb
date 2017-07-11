class AddEquipmentIdToServiceRequest < ActiveRecord::Migration
  def change
    add_column :service_requests, :equipment_id, :string
  end
end
