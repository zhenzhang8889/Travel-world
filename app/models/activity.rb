# == Schema Information
#
# Table name: activities
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  category_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Activity < ActiveRecord::Base
  attr_accessible :name, :actcate

  has_and_belongs_to_many :profiles
  belongs_to :actcate, :foreign_key => 'category_id'

  validates :name, :presence => true, :uniqueness=> true
end


