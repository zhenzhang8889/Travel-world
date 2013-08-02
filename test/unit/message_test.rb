# == Schema Information
#
# Table name: messages
#
#  id                  :integer          not null, primary key
#  content             :text
#  created_at          :datetime
#  updated_at          :datetime
#  ack                 :boolean
#  status              :string(255)
#  message_thread_id   :integer
#  user_id             :integer
#  acked               :string(255)
#  attach_file_name    :string(255)
#  attach_content_type :string(255)
#  attach_file_size    :integer
#  attach_updated_at   :datetime
#

require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
