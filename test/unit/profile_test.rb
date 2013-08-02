# == Schema Information
#
# Table name: profiles
#
#  id                     :integer          not null, primary key
#  name                   :string(255)
#  activity_details       :text
#  website                :string(255)
#  marketing_network      :string(255)
#  country                :string(255)
#  region                 :string(255)
#  street                 :string(255)
#  city                   :string(255)
#  freephone              :string(255)
#  phone                  :string(255)
#  fax                    :string(255)
#  business_hours         :string(255)
#  user_id                :integer
#  step                   :integer          default(0)
#  activity_id            :integer
#  month_enhanced         :integer
#  year_enhanced          :integer
#  month_product_launched :integer
#  year_product_launched  :integer
#  product_status         :string(255)
#  qualmark_accredited    :integer
#  qualmark_rating        :integer
#  suburb                 :string(255)
#  commission             :boolean
#  rooms                  :string(255)
#  capacity               :string(255)
#  duration               :string(255)
#  larger_org             :string(255)
#  min_age                :string(255)
#  months_of_operation    :string(255)
#  languages              :string(255)
#  collateral             :string(255)
#  retail_rate            :string(255)
#  child_rate             :string(255)
#  pricing_info           :text
#  cancellation           :text
#  facilities             :text
#  media_angle            :text
#  domestic               :integer
#  international          :integer
#  independent            :integer
#  groups                 :integer
#  promote                :text
#  brochures              :text
#  country_id             :integer
#  service_id             :integer
#  avatar_file_name       :string(255)
#  avatar_content_type    :string(255)
#  avatar_file_size       :integer
#  avatar_updated_at      :datetime
#  profile_type_id        :integer
#  cover_file_name        :string(255)
#  cover_content_type     :string(255)
#  cover_file_size        :integer
#  cover_updated_at       :datetime
#  cover_type             :string(255)      default("single")
#  time_zone              :string(255)
#  tourist_type_id        :integer
#  open_for_public        :boolean          default(TRUE)
#  open_for_member        :boolean          default(FALSE)
#  term                   :boolean          default(FALSE)
#  twitter                :string(255)
#  facebook               :string(255)
#  google_plus            :string(255)
#  tumblr                 :string(255)
#  view_times             :integer          default(0)
#  looking_for_service_id :integer
#  providing_service_id   :integer
#  show_location          :string(255)      default("both")
#  slug                   :text
#  contact_button         :string(255)      default("Hire Me")
#  show_contact_button    :boolean          default(TRUE)
#  avatar_croped          :boolean          default(TRUE)
#  area_id                :integer
#  recommend              :boolean          default(FALSE)
#  created_at             :datetime
#  updated_at             :datetime
#

require 'test_helper'

class ProfileTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
