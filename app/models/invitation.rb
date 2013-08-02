# == Schema Information
#
# Table name: invitations
#
#  id         :integer          not null, primary key
#  email      :string(255)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Invitation < ActiveRecord::Base
  attr_accessible :email, :user_id

  belongs_to :user
  has_one :invite_user, :class_name => 'User'
  has_one :users_following

  def launch_users_following usr
    self.create_users_following(:state => 'active', :following => self.user, :follower => usr)
    self.user.notifications.create(:signup_invitation => self)
  end

end
