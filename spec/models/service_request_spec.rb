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

require 'rails_helper'

RSpec.describe ServiceRequest, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
