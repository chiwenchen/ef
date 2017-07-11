class AddTranslatedBodyToComments < ActiveRecord::Migration
  def change
    add_column :comments, :translated_body, :text
  end
end