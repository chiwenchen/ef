# == Schema Information
#
# Table name: attachments
#
#  id                 :uuid             not null, primary key
#  file_path          :string
#  service_request_id :uuid
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Attachment < ActiveRecord::Base
  belongs_to :service_request, inverse_of: :attachments
  mount_uploader :file_path, AttachmentUploader
  validates :file_path, file_size: { less_than: 20.megabytes }
end
