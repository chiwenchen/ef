class CreateCategories < ActiveRecord::Migration
  def change
    enable_extension 'uuid-ossp'
    create_table :categories, id: :uuid do |t|
      t.string :title
      t.timestamps null: false
    end
  end
end
