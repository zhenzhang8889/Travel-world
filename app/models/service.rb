# == Schema Information
#
# Table name: services
#
#  id         :integer          not null, primary key
#  code       :string(255)
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Service < ActiveRecord::Base
  attr_accessible :code, :name
  has_many :profiles

  has_many :providing_profiles, :class_name => 'Profile', :foreign_key => 'providing_service_id'
end
