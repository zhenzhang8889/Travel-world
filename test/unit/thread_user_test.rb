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

require 'test_helper'

class ThreadUserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
