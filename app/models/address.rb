# == Schema Information
#
# Table name: addresses
#
#  id         :integer          not null, primary key
#  number     :string(255)
#  street     :text
#  city       :string(255)
#  region     :string(255)
#  country    :string(255)
#  zip        :string(255)
#  phone      :string(255)
#  profile_id :integer
#  security   :boolean
#  created_at :datetime
#  updated_at :datetime
#

class Address < ActiveRecord::Base
  attr_accessible :number, :street, :city, :region, :country, :zip, :phone, :profile_id, :security

  def to_stream
    "#{self.number}  #{self.street} #{self.city} #{self.region} #{self.country} #{self.zip}"
  end
end

