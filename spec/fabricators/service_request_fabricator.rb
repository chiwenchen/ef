# == Schema Information
#
# Table name: service_requests
#
#  id              :uuid             not null, primary key
#  request_id      :string
#  title           :string
#  customer_id     :uuid
#  category_id     :uuid
#  description     :text
#  deadline        :date
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  state           :string
#  translated_desc :text
#  equipment_id    :string
#

Fabricator(:service_request) do
  id          ""
  request_id  "MyString"
  title       "MyString"
  customer_id ""
  category_id ""
  description "MyText"
  deadline    "2017-04-26"
  created_at  "2017-04-26 17:55:19"
  updated_at  "2017-04-26 17:55:19"
end
