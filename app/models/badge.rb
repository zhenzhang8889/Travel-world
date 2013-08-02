# == Schema Information
#
# Table name: badges
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  point             :integer
#  is_active         :boolean
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  category_badge_id :integer
#

class Badge < ActiveRecord::Base
  attr_accessible :is_active, :name, :point, :category_badge_id

  belongs_to :category_badge

  def self.count_point(badges)
    badges.collect{ |b| b.point }.sum
  end

  def completed_note(current_user)
    note = ""
    completed_badge = UserCompletedBadge.find(:first,
      :conditions => { :user_id => current_user.id, :badge_id => self.id } )
    note = completed_badge.note if completed_badge
    note
  end
  
end
