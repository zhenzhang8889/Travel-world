# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  traveler               :boolean          default(FALSE)
#  firstName              :string(255)
#  lastName               :string(255)
#  country                :string(255)
#  city                   :string(255)
#  description            :string(255)
#  category_id            :integer
#  avatar_file_name       :string(255)
#  avatar_content_type    :string(255)
#  avatar_file_size       :integer
#  avatar_updated_at      :datetime
#  active                 :boolean          default(TRUE)
#  is_enabled             :boolean
#  decrypted              :string(255)
#  is_level2_admin        :boolean
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :email_confirmation, :password, :password_confirmation, :remember_me
  validates_confirmation_of :email, :on => :create
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :quick_messages, :quick_message_ids, :messages, 
    :message_ids, :message_threads, :message_thread_ids, :thread_users, :thread_user_id, :firstName, :lastName,
    :country, :city, :description, :category_id, :category, :traveler, :avatar

  has_one :profile, :dependent => :destroy
  has_many :lead_generations, :dependent => :destroy
  has_many :quick_messages
  has_many :groups
  has_many :contacts, :through => :groups
  has_many :users, :through => :contacts

  has_many :message_threads, :through => :thread_users
  has_many :thread_users
  has_many :messages
  has_many :usracts
  has_many :posts
  has_many :googletokens
  has_one  :google, :class_name => "GoogleToken", :dependent => :destroy
  
  has_many :user_completed_badges
  has_many :user_visit_histories
  has_many :visited_histories, :class_name => "UserVisitHistory",
    :foreign_key => :visitor_id

  has_many :refertos, :foreign_key => 'to_id'
  has_private_messages
  
  has_many :chattings
  has_one :primary_chatting, :class_name => "Chatting", :conditions => {:primary => true} 
  
  belongs_to :category
  belongs_to :invitation
  before_save :save_decrypted_password

  has_attached_file :avatar, 
    :styles => { :medium => "49x49>", :small => "30x30>" },
    :storage => Rails.env.production? ? :s3 : :filesystem,
    :s3_credentials => "#{Rails.root}/config/s3.yml",
    :default_url => '/assets/avatar_:style_missing.png'

  def avatar_url type
    if self.profile && self.profile.prof_avatar.try(:data)
      return self.profile.prof_avatar.data.url(type)
    end
    return self.avatar.url(type)
  end

  def last_visited
    self.visited_histories.last.created_at unless self.visited_histories.blank?
  end

  def completed_badge_ids
    self.user_completed_badges.collect{ |x| x.badge_id }
  end

  def visit_profile(target_lead, user_lead)
    visit_history = UserVisitHistory.new
    visit_history.user_id = target_lead.user.id
    visit_history.visitor_id = self.id
    visit_history.service_id = user_lead.service_id
    visit_history.lead_generation_id = user_lead.id
    profile = self.profile
    visit_history.country = profile.country if profile and profile.country
    visit_history.save
  end

  def count_tasks_point(badges, total_point, completed_ids = [])
    user_completed_badges = completed_ids.blank? ? completed_badge_ids : completed_ids
    score = 0
    badges.each do |badge|
      if user_completed_badges.include? badge.id
        score += badge.point
      end
    end

    score = (score.to_f / total_point.to_f) * 100

    begin
      score.round.to_i
    rescue
      return 0
    end
  end

  def threads
    MessageThread.where("owner_id = ? OR receiver_id = ?", self.id)
  end

  def getConversation(id)
    MessageThread.includes(:users).where("message_threads_users.message_thread_id IN (?) AND message_threads_users.user_id = ? \
                                          AND archived = ?", 
      self.message_threads.collect { |a| a.id }, id, false )
  end

  def imageUrlSmall
    self.avatar_url(:small)
  end

  def imageUrlMedium
    self.avatar_url(:medium)
  end

  def service_tag
    self.try(:profile).try(:service).try(:name)
  end

  def service_name
    self.try(:profile).try(:service).try(:name)
  end
  def area_name
    self.try(:profile).try(:area).try(:name)
  end

  def categoryName
    if self.profile && self.profile && self.profile.service
      return self.profile.service.name
    end
    ''
    # if self.category.nil?
    #   return self.description
    # else
    #   return self.category.name
    # end
  end

  def full_name
    "#{self.firstName} #{self.lastName}"
  end

  def name
    self.full_name
  end

  def subName
    self.city + " (" + self.country + ") " + self.categoryName
  end

  def first_time_login!
    if self.invitation
      selfid = self.id
      User.where(:invitation_id => self.invitation.id).where{id.not_eq(selfid)}.each do |usr|
        usr.invitation_id = nil
        usr.save(:validate => false)
      end

      self.invitation.launch_users_following self
    end
  end

  def generate_random_password
    random_password = ([nil]*8).map { ((48..57).to_a+(65..90).to_a+(97..122).to_a).sample.chr }.join
    self.password = random_password
    self.password_confirmation = random_password
  end

  def self.new_from_params(user_params)
    user = User.new
    user.assign_attributes_from_params(user_params)
    user
  end

  def assign_attributes_from_params(user_params)
    self.email = user_params[:email]
    self.firstName = user_params[:firstName]
    self.lastName = user_params[:lastName]
    self.country = user_params[:country]
    self.city = user_params[:city]
    self.description = user_params[:description]
    self.category_id = user_params[:category_id]
    self.active = user_params[:active]

    if !user_params[:password].blank? and !user_params[:password_confirmation].blank?
      self.password = user_params[:password]
      self.password_confirmation = user_params[:password_confirmation]
    end

  end

  def full_address
    if self.profile
      street_city_region = "#{self.profile.street} #{self.profile.city} #{self.profile.region}"
    end
    if street_city_region.blank?
      self.country
    else
      "#{street_city_region}, #{self.country}"
    end
  end

  private

  def save_decrypted_password
    self.decrypted = self.password unless self.password.blank?
  end


  # def is_company?
  #   self.utype == 'company'
  # end

  # def is_traveller?
  #   self.utype == 'traveller'
  # end

  # def is_active?
  #   (self.is_company? && self.profile.try(:active?)) || self.is_traveller?
  # end

end
