# == Schema Information
#
# Table name: comment_documents
#
#  id         :uuid             not null, primary key
#  file_path  :string
#  comment_id :uuid
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CommentDocument < ActiveRecord::Base
  belongs_to :comment
  mount_uploader :file_path, CommentDocumentUploader
end
