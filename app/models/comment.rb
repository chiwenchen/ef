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

class Comment < ActiveRecord::Base
  belongs_to :service_request
  belongs_to :user
  validates_presence_of :body
end
