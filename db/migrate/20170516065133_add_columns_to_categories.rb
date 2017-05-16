class AddColumnsToCategories < ActiveRecord::Migration
  def change
    remove_column :categories, :title
    add_column :categories, :tw_title, :string
    add_column :categories, :en_title, :string
  end
end
