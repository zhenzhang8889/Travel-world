# == Schema Information
#
# Table name: countries
#
#  id                :integer          not null, primary key
#  code              :string(255)
#  name              :string(255)
#  ltype             :string(255)      default("country")
#  lorder            :string(255)      default("99")
#  location_group_id :integer
#  created_at        :datetime
#  updated_at        :datetime
#

require 'test_helper'

class CountryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
