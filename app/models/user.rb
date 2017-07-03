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
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  has_many :service_requests, foreign_key: :customer_id
  has_many :comments
  has_many :assignments
  has_many :assigned_service_requests, through: :assignments, source: :service_request

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

  royce_roles [ :admin, :sales, :tech, :customer ]
end
