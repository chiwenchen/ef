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

Fabricator(:category) do
end
