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

require 'test_helper'

class QuickMessageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
