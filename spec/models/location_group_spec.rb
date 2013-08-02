# == Schema Information
#
# Table name: location_groups
#
#  id         :integer          not null, primary key
#  code       :string(255)
#  name       :string(255)
#  lorder     :integer          default(99)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe LocationGroup do
  pending "add some examples to (or delete) #{__FILE__}"
end
