# == Schema Information
#
# Table name: actcates
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Actcate < ActiveRecord::Base
  has_many :activities
end



