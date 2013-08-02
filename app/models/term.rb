# == Schema Information
#
# Table name: terms
#
#  id         :integer          not null, primary key
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Term < ActiveRecord::Base
  attr_accessible :body
end
