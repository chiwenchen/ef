# == Schema Information
#
# Table name: images
#
#  id                 :uuid             not null, primary key
#  file               :string
#  service_request_id :uuid
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'rails_helper'

RSpec.describe Image, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
