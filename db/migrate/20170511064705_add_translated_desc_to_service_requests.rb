class AddTranslatedDescToServiceRequests < ActiveRecord::Migration
  def change
    add_column :service_requests, :translated_desc, :text
  end
end
