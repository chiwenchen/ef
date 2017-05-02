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

class Assignment < ActiveRecord::Base
  belongs_to :user
  belongs_to :service_request
end
