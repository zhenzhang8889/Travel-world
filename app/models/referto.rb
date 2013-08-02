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

class Referto < ActiveRecord::Base
  attr_accessible :from, :referable, :to

  scope :posts, where(:referable_type => 'Post')
  scope :members, where(:referable_type => 'User')

  belongs_to :referable, :polymorphic => true
  belongs_to :from, :class_name => 'User'
  belongs_to :to, :class_name => 'User'

  scope :to_users, where(:referable_type => 'User')
  scope :to_posts, where(:referable_type => 'Post')
end
