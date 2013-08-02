# == Schema Information
#
# Table name: location_groups
#
#  id         :integer          not null, primary key
#  code       :string(255)
#  name       :string(255)
#  lorder     :integer          default(99)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class LocationGroup < ActiveRecord::Base
  attr_accessible :code, :name, :lorder

  has_many :countries, :order => "lorder ASC, name ASC"

  has_many :areas, :order => "name ASC"

  def self.global
    LocationGroup.find_by_code('global')
  end

  def self.country
    LocationGroup.find_by_code('country')
  end

  def self.continent
    LocationGroup.find_by_code('continent')
  end
end

