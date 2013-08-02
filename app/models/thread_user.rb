# == Schema Information
#
# Table name: thread_users
#
#  id                :integer          not null, primary key
#  deleted           :boolean
#  archived          :boolean
#  created_at        :datetime
#  updated_at        :datetime
#  user_id           :integer
#  message_thread_id :integer
#

class ThreadUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :message_thread

  before_create :set_false

  def set_false
    self.deleted = false
    self.archived = false

    true
  end
end
