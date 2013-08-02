# == Schema Information
#
# Table name: profile_types
#
#  id         :integer          not null, primary key
#  code       :string(255)
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class ProfileType < ActiveRecord::Base
end
