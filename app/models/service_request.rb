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
#  used_lang       :string
#

class ServiceRequest < ActiveRecord::Base
  belongs_to :category
  belongs_to :customer, foreign_key: :customer_id, class_name: 'User'
  has_many :images, dependent: :destroy, inverse_of: :service_request
  has_many :attachments, dependent: :destroy, inverse_of: :service_request
  accepts_nested_attributes_for :images, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :attachments, reject_if: :all_blank, allow_destroy: true
  has_many :comments

  has_many :assignments
  has_many :responsibles, through: :assignments, source: :user
  accepts_nested_attributes_for :assignments, reject_if: :all_blank, allow_destroy: true

  extend Enumerize
  enumerize :state, in: [:initial, :processing, :complete, :close], default: :initial

  include AASM

  aasm column: :state do
    state :initial, initial: true
    state :processing
    state :complete
    state :close

    event :process do
      transitions from: :initial, to: :processing
    end

    event :complete do
      transitions from: :processing, to: :complete
    end

    event :close do
      transitions from: :complete, to: :close
    end

    event :reject do
      transitions from: :complete, to: :processing
    end
  end

end
