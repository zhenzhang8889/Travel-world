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

require 'spec_helper'

describe Notification do
  pending "add some examples to (or delete) #{__FILE__}"
end
