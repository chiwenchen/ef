class Comment < ActiveRecord::Base
  belongs_to :service_request
  belongs_to :user
  validates_presence_of :body
end
