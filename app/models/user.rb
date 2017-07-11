# == Schema Information
#
# Table name: users
#
#  id                     :uuid             not null, primary key
#  email                  :string           default("")
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  username               :string
#  line_user_id           :string
#  owner_id               :uuid
#  sales_id               :uuid
#  tech_id                :uuid
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  has_many :service_requests, foreign_key: :customer_id
  has_many :comments
  has_many :assignments
  has_many :assigned_service_requests, through: :assignments, source: :service_request

  belongs_to :owner, class_name: 'User'
  has_many :responsible_for, class_name: 'User', foreign_key: 'owner_id'

  belongs_to :sales, class_name: 'User'
  has_many :sales_for, class_name: 'User', foreign_key: 'sales_id'

  belongs_to :tech, class_name: 'User'
  has_many :tech_for, class_name: 'User', foreign_key: 'tech_id'

  belongs_to :sales, class_name: 'User'
  has_one :user, class_name: 'User', foreign_key: 'sales_id'

  belongs_to :tech, class_name: 'User'
  has_one :user, class_name: 'User', foreign_key: 'tech_id'

  validates_uniqueness_of :username

  attr_accessor :role
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  def email_required?
    false
  end

  def email_changed?
    false
  end

  def responsibles
    [self.owner, self.sales, self.tech].delete_if {|obj| obj == nil }
  end

  royce_roles [ :admin, :sales, :tech, :customer ]
end
