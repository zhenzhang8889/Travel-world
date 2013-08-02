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

class Profile < ActiveRecord::Base
  attr_accessible :address_attributes, :name, :activity_details, :website, :marketing_network, :country, :region, :street, :city, :freephone, :phone, :fax, :business_hours, :user_id, :step, :activity_id, :month_enhanced, :year_enhanced, :month_product_launched, :year_product_launched, :product_status, :qualmark_accredited, :qualmark_rating, :suburb, :commission, :rooms, :capacity, :duration, :larger_org, :min_age, :months_of_operation, :languages, :collateral, :retail_rate, :child_rate, :pricing_info, :cancellation, :facilities, :media_angle, :domestic, :international, :independent, :groups, :promote, :brochures, :country_id, :service_id, :avatar_file_name, :avatar_content_type, :avatar_file_size, :avatar_updated_at, :profile_type_id, :cover_file_name, :cover_content_type, :cover_file_size, :cover_updated_at, :cover_type, :time_zone, :tourist_type_id, :open_for_public, :open_for_member, :term, :twitter, :facebook, :google_plus, :tumblr, :view_times, :looking_for_service_id, :providing_service_id, :show_location, :slug, :contact_button, :show_contact_button, :avatar_croped, :area_id, :recommend, :activity_ids, :pre_prof_avatar_attributes, :pre_prof_avatar

  belongs_to :user
  belongs_to :country
  belongs_to :area
  belongs_to :service
  belongs_to :profile_type
  # belongs_to :tourist_type
  belongs_to :looking_for_service, :class_name => 'Service'
  belongs_to :providing_service, :class_name => 'Service'

  has_one :address, :dependent => :destroy
  accepts_nested_attributes_for :address, :allow_destroy => true
  # :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } }

  has_one :prof_avatar, :conditions => { :p_state => 'active' }
  has_one :pre_prof_avatar, :class_name => 'ProfAvatar', :conditions => { :p_state => 'inactive' }
  accepts_nested_attributes_for :pre_prof_avatar

  scope :active_scope, includes(:user).where{profiles.step.gte 3}.where(:term => true).where(:users => {:active => true})
  def active?
    self.step >= 3 && self.term
  end

  has_and_belongs_to_many :activities
  acts_as_taggable_on :special_acts

  validate :term, :must_be_true
  def must_be_true
    if self.step == 2 && self.term == false
      errors.add(:term, "Please agree to our T&Cs.")
    end
  end

  def assign_attributes_from_params(profile_params)
    self.service_id = profile_params[:service_id]
    self.name = profile_params[:name]
    self.area_id = profile_params[:area_id]
    self.street = profile_params[:street]
    self.city  = profile_params[:city]
    self.region = profile_params[:region]
    self.country = profile_params[:country]
    self.activity_id = profile_params[:activity_id]
    self.phone = profile_params[:phone]
    self.website = profile_params[:website]
  end

  def show_location?
    self.show_location == 'both' || self.show_location == 'location'
  end

  def show_region?
    self.show_location == 'both' || self.show_location == 'region'
  end
end
