# == Schema Information
#
# Table name: user_visit_histories
#
#  id                 :integer          not null, primary key
#  user_id            :integer
#  visitor_id         :integer
#  service_id         :integer
#  lead_generation_id :integer
#  country            :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class UserVisitHistory < ActiveRecord::Base
  belongs_to :user
  belongs_to :visitor, :class_name => "User", :foreign_key => :visitor_id
end
