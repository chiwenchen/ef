class FixUsedLangToServiceRequests < ActiveRecord::Migration
  def change
    add_column :service_requests, :used_lang, :string
    remove_column :service_requests, :userd_lang, :string
  end
end
