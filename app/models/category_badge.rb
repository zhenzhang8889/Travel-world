# == Schema Information
#
# Table name: category_badges
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CategoryBadge < ActiveRecord::Base
  attr_accessible :name
end
