class AddUserdLangToServiceRequests < ActiveRecord::Migration
  def change
    add_column :service_requests, :userd_lang, :string
  end
end
