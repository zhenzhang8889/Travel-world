# == Schema Information
#
# Table name: areas
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  parent_id         :integer
#  sub_area_url      :text
#  host_url          :text
#  atype             :string(255)
#  location_group_id :integer
#  created_at        :datetime
#  updated_at        :datetime
#

require 'test_helper'

class AreaTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
