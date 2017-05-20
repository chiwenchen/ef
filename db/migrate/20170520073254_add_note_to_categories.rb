class AddNoteToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :note, :string
  end
end
