# == Schema Information
#
# Table name: service_requests
#
#  id          :uuid             not null, primary key
#  request_id  :string
#  title       :string
#  customer_id :uuid
#  category_id :uuid
#  description :text
#  deadline    :date
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  state       :string
#

class ServiceRequest < ActiveRecord::Base
  belongs_to :category
  belongs_to :customer, foreign_key: :customer_id, class_name: 'User'
  has_many :images, dependent: :destroy, inverse_of: :service_request
  has_many :attachments, dependent: :destroy, inverse_of: :service_request
  accepts_nested_attributes_for :images, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :attachments, reject_if: :all_blank, allow_destroy: true
  has_many :comments

  extend Enumerize
  enumerize :state, in: [:initial, :processing, :complete], default: :initial

  # include AASM

  # aasm column: :state do
  #   state :available, initial: true
  #   state :booked

  #   event :book do
  #     transitions from: :available, to: :booked
  #   end

  #   event :cancel do
  #     transitions from: :booked, to: :available
  #   end
  # end

end
