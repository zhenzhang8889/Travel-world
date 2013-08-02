# == Schema Information
#
# Table name: lead_generations
#
#  id              :integer          not null, primary key
#  lg_type         :string(255)
#  location_id     :integer
#  lg_state        :string(255)      default("live")
#  user_id         :integer
#  rank            :float            default(0.0)
#  lg_product_type :string(255)
#  subject         :text
#  details         :text
#  area_id         :integer
#  area_desc       :text
#  sub_area_id     :integer
#  traveller_id    :integer
#  service_id      :integer
#  start_date      :date
#  end_date        :date
#  is_today        :boolean
#  call_me         :boolean
#  email_me        :boolean
#  proftag         :boolean          default(FALSE)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'spec_helper'

describe LeadGeneration do
  pending "add some examples to (or delete) #{__FILE__}"
end
