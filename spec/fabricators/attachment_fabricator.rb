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

Fabricator(:attachment) do
end
