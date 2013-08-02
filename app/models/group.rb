# == Schema Information
#
# Table name: groups
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#  traveler   :boolean
#

class Group < ActiveRecord::Base
  attr_accessible :name, :user_id, :traveler

  belongs_to :user
  has_many :contacts, :dependent => :delete_all
  has_many :users, :through => :contacts
end
