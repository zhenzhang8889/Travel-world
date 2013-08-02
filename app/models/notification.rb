# == Schema Information
#
# Table name: notifications
#
#  id                   :integer          not null, primary key
#  user_id              :integer
#  kind                 :integer
#  message              :string(255)
#  link                 :string(255)
#  contact_id           :integer
#  state                :string(255)      default("new")
#  noti_type            :string(255)
#  users_following_id   :integer
#  read                 :boolean          default(FALSE)
#  is_del               :boolean          default(FALSE)
#  lead_generation_id   :integer
#  signup_invitation_id :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

class Notification < ActiveRecord::Base
  attr_accessible :lead_generation, :user

  belongs_to :user
  belongs_to :users_following
  belongs_to :signup_invitation, :class_name => 'Invitation'

  # has_and_belongs_to_many :lead_generations
  belongs_to :lead_generation

  scope :unread, where(:read => false)
  scope :not_del, where(:is_del => false)

  before_create :init_type
  def init_type
    if self.users_following && self.users_following.is_init?
      self.noti_type = 'follow'
    elsif self.lead_generation
      self.noti_type = 'lead'
    elsif self.signup_invitation
      self.noti_type = 'invitation_signup'
    end
  end

  def mail_title
    if self.lead_type?
      return "Found Live Leads matches yours on traveltagged.com"
    end

    self.message || ''
  end

  def lead_type?
    self.noti_type == 'lead' && self.lead_generation
  end

  def is_follow?
    return true if self.users_following
    false
  end

  def follow_req?
    self.users_following && self.users_following.is_init?
  end

  def follow_cancel?
    self.users_following && self.users_following.is_cancel?
  end

  def follow_accepted?
    self.users_following && self.users_following.is_accept?
  end

  def follow_denied?
    self.users_following && self.users_following.is_decline?
  end

  def signup_invitation?
    self.noti_type == 'invitation_signup'
  end

  def read!
    self.read = true
    self.save(:validate => false)
  end

  def mark_del!
    self.is_del = true
    self.save(:validate => false)
  end
end







