# == Schema Information
#
# Table name: images
#
#  id                 :uuid             not null, primary key
#  file_path          :string
#  service_request_id :uuid
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Image < ActiveRecord::Base
  belongs_to :service_request, inverse_of: :images
  mount_uploader :file_path, ImageUploader
end
