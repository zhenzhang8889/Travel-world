# == Schema Information
#
# Table name: contacts
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  group_id   :integer
#  created_at :datetime
#  updated_at :datetime
#

class Contact < ActiveRecord::Base
  attr_accessible :user, :group

  belongs_to :user
  belongs_to :group
end
