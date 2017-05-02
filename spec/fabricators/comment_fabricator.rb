# == Schema Information
#
# Table name: comments
#
#  id                 :integer          not null, primary key
#  service_request_id :uuid
#  user_id            :uuid
#  body               :text
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

Fabricator(:comment) do
end
