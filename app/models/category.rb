# == Schema Information
#
# Table name: categories
#
#  id         :uuid             not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  tw_title   :string
#  en_title   :string
#

class Category < ActiveRecord::Base
  has_many :service_requests
  validates_uniqueness_of :tw_title, :en_title
  validates_presence_of :tw_title, :en_title

  def title
    if I18n.locale == :'zh-TW'
      tw_title
    else
      en_title
    end
  end

end
