# == Schema Information
#
# Table name: usracts
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  atype      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Usract < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :user
end
