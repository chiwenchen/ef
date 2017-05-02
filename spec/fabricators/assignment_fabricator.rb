# == Schema Information
#
# Table name: assignments
#
#  id                 :uuid             not null, primary key
#  service_request_id :uuid
#  user_id            :uuid
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

Fabricator(:assignment) do
end
