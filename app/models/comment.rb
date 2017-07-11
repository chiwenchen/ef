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

class Comment < ActiveRecord::Base
  belongs_to :service_request
  belongs_to :user
  has_many :comment_documents
  accepts_nested_attributes_for :comment_documents, reject_if: :all_blank, allow_destroy: true
  validates_presence_of :body
end
