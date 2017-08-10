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

  # has_many :assignments
  # has_many :responsibles, through: :assignments, source: :user
  # accepts_nested_attributes_for :assignments, reject_if: :all_blank, allow_destroy: true

  before_create :generate_request_id

  validate :equipment_id_validation

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

  def generate_request_id
    year = Time.current.year.to_s[2,3]
    request_id = (year + '001').to_i
    loop do
      break unless self.class.find_by(request_id: request_id)
      request_id += 1
    end
    return self.request_id = request_id
  end

  def equipment_id_validation
    unless /EF-\d\d\d\d\b/ =~ self.equipment_id || self.equipment_id == ""
      errors.add(:equipment_id, I18n.t('error.invalid_equipment_id'))
    end
  end

  def owner
    self.customer.owner
  end

  def sales
    self.customer.sales
  end

  def tech
    self.customer.tech
  end
end
