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

class ProfAvatar < ActiveRecord::Base
  attr_accessible :data, :need_chop, :chop_x, :chop_y, :chop_w, :chop_h


  has_attached_file :data,
                    :styles => {
                                :medium => {:geometry => "360x360>", :c_ratio => 1},
                                :thumb => {:geometry => "120x120", :c_ratio => 0.33}
                              },
                    :convert_options => {
                      :medium => '-background white -gravity center -extent 360x360',
                      :thumb => '-background white -gravity center -extent 120x120'
                    },
                    :storage => :s3, :s3_credentials => 'config/s3.yml',
                    :default_url => '/assets/avatar_:style_missing.png',
                    :processors => [:thumbnail, :chop]

  attr_accessor :need_chop, :chop_x, :chop_y, :chop_w, :chop_h

  def medium_url
    self.data.url(:medium)
  end

end
