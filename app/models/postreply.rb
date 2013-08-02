# == Schema Information
#
# Table name: postreplies
#
#  id         :integer          not null, primary key
#  body       :text
#  post_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#

class Postreply < ActiveRecord::Base
  attr_accessible :body

  belongs_to :user
  belongs_to :post
end
