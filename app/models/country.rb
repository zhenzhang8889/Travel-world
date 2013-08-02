# == Schema Information
#
# Table name: countries
#
#  id                :integer          not null, primary key
#  code              :string(255)
#  name              :string(255)
#  ltype             :string(255)      default("country")
#  lorder            :string(255)      default("99")
#  location_group_id :integer
#  created_at        :datetime
#  updated_at        :datetime
#

class Country < ActiveRecord::Base
  has_many :profiles
  belongs_to :location_group
end


