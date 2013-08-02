# == Schema Information
#
# Table name: addresses
#
#  id         :integer          not null, primary key
#  number     :string(255)
#  street     :text
#  city       :string(255)
#  region     :string(255)
#  country    :string(255)
#  zip        :string(255)
#  phone      :string(255)
#  profile_id :integer
#  security   :boolean
#  created_at :datetime
#  updated_at :datetime
#

require 'test_helper'

class AddressTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
