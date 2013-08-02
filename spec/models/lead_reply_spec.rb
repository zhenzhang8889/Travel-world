# == Schema Information
#
# Table name: lead_replies
#
#  id                 :integer          not null, primary key
#  lead_generation_id :integer
#  user_id            :integer
#  target_user_id     :integer
#  body               :text
#  read               :boolean          default(FALSE)
#  del_by_user        :boolean          default(FALSE)
#  del_by_target_user :boolean          default(FALSE)
#  original_lead_id   :integer
#  target_lead_id     :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'spec_helper'

describe LeadReply do
  pending "add some examples to (or delete) #{__FILE__}"
end
