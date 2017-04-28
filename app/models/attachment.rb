# == Schema Information
#
# Table name: attachments
#
#  id                 :uuid             not null, primary key
#  file               :string
#  service_request_id :uuid
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Attachment < ActiveRecord::Base
  belongs_to :service_request, inverse_of: :attachments
  mount_uploader :file, AttachmentUploader
end
