class CreateCommentDocuments < ActiveRecord::Migration
  def change
    enable_extension 'uuid-ossp'
    create_table :comment_documents, id: :uuid do |t|
      t.string :file_path
      t.uuid :comment_id
      t.timestamps null: false
    end
  end
end
