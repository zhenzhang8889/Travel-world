# == Schema Information
#
# Table name: user_completed_badges
#
#  id       :integer          not null, primary key
#  badge_id :integer
#  user_id  :integer
#  note     :string(255)
#

class UserCompletedBadge < ActiveRecord::Base
  belongs_to :user
  belongs_to :badge
end
