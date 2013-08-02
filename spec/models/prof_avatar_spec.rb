# == Schema Information
#
# Table name: prof_avatars
#
#  id                :integer          not null, primary key
#  chop_x            :float
#  chop_y            :float
#  chop_h            :float
#  chop_w            :float
#  profile_id        :integer
#  p_state           :string(255)      default("active")
#  data_file_name    :string(255)
#  data_content_type :string(255)
#  data_file_size    :integer
#  data_updated_at   :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'spec_helper'

describe ProfAvatar do
  pending "add some examples to (or delete) #{__FILE__}"
end
