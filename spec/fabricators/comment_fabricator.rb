# == Schema Information
#
# Table name: comments
#
#  id                 :uuid             not null, primary key
#  service_request_id :uuid
#  user_id            :uuid
#  body               :text
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  translated_body    :text
#

Fabricator(:comment) do
end
