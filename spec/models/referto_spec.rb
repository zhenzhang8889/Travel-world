# == Schema Information
#
# Table name: refertos
#
#  id             :integer          not null, primary key
#  from_id        :integer
#  to_id          :integer
#  referable_id   :integer
#  referable_type :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'spec_helper'

describe Referto do
  pending "add some examples to (or delete) #{__FILE__}"
end
