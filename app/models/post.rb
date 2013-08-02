# == Schema Information
#
# Table name: posts
#
#  id                :integer          not null, primary key
#  body              :text
#  data_file_name    :string(255)
#  data_content_type :string(255)
#  data_file_size    :integer
#  data_updated_at   :datetime
#  user_id           :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  refer_to_id       :integer
#

class Post < ActiveRecord::Base
  attr_accessible :body, :data, :refer_to_id

  has_attached_file :data,
                    :styles => {:large => {:geometry => "560x560>"}, 
                                :medium => {:geometry => "360x360>"},
                                :thumb => {:geometry => "120x120>"}},
                    :storage => :s3, :s3_credentials => 'config/s3.yml'

  belongs_to :user
  has_many :postreplies
  # belongs_to :refer_to, :class_name => 'User'
  has_and_belongs_to_many :refer_tos, :class_name => 'User', :join_table => 'posts_refer_to_users'

  def medium_data_url
    if !self.data_file_size.nil?
      return self.data.url(:medium)
    end
    nil
  end
end
