# == Schema Information
#
# Table name: quick_messages
#
#  id         :integer          not null, primary key
#  body       :text
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#

class QuickMessage < ActiveRecord::Base
  belongs_to :user
  attr_accessible :body, :user_id
end
