# == Schema Information
#
# Table name: categories
#
#  id         :uuid             not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Category < ActiveRecord::Base
  has_many :service_requests
end
