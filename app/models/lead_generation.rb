# == Schema Information
#
# Table name: lead_generations
#
#  id              :integer          not null, primary key
#  lg_type         :string(255)
#  location_id     :integer
#  lg_state        :string(255)      default("live")
#  user_id         :integer
#  rank            :float            default(0.0)
#  lg_product_type :string(255)
#  subject         :text
#  details         :text
#  area_id         :integer
#  area_desc       :text
#  sub_area_id     :integer
#  traveller_id    :integer
#  service_id      :integer
#  start_date      :date
#  end_date        :date
#  is_today        :boolean
#  call_me         :boolean
#  email_me        :boolean
#  proftag         :boolean          default(FALSE)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class LeadGeneration < ActiveRecord::Base
  include ActionView::Helpers::TextHelper

  attr_accessible :lg_type, :service_id, :area_id, :area_desc, :keyword_list, :details
  attr_accessor :ranking
  belongs_to :user
  # belongs_to :traveller
  belongs_to :location, :class_name => 'Country'
  belongs_to :area
  belongs_to :sub_area, :class_name => 'Area'
  belongs_to :service

  has_and_belongs_to_many :services
  has_and_belongs_to_many :activities
  has_many :lead_replies

  acts_as_taggable_on :keywords

  scope :active_scope, where(:lg_state => 'live')
  scope :match_against_with_live_leads, lambda { |lead_generation|
    match_against(lead_generation)
  }

  scope :match_against, lambda { |lead_generation|
    rs = top_level_match(lead_generation)\
            .tagged_with(Word.expend_with_relationship(lead_generation.keywords), :any => true)

    if lead_generation.sub_area
      rs = rs.where(:sub_area_id => lead_generation.sub_area_id)
    end
    rs
  }

  scope :top_level_match, lambda { |lead|
    rs = active_scope.where{user_id.not_eq lead.user.id}\
    .where(:lg_type => lead.is_providing? ? 'looking_for' : 'providing')\
    .where(:service_id => lead.service_id)

    unless lead.area.try(:is_global?)
      rs = rs.where(:area_id => lead.area.try(:get_matching_ids))
    end

    rs
  }

  def cal_ranking other
    self.ranking = 0
    self.ranking = self.ranking + 5 if self.sub_area_id == other.sub_area_id
    self.ranking = self.ranking + (self.keyword_list.map(&:to_s) & other.keyword_list.map(&:to_s)).size
  end

  def keyword_ranking lead
    rs = 0
    lead.keywords.each do |keyword|
      if word = Word.get_from_real_word(keyword.to_s)

        self.keywords.map(&:to_s).collect {|ele| Word.get_from_real_word(ele)}.each do |self_word|
          if self_word
            if self_word.value.to_s == word.value.to_s
              rs = rs + WordRelation.max_ranking
            else
              rel = WordRelation.related_to_word(word).related_to_word(self_word)
              if !rel.blank?
                rs = rs + rel.first.ranking
              end
            end
          end
        end
      end
    end

    (lead.keywords.map(&:to_s).map(&:downcase).map(&:strip).uniq &
    self.keywords.map(&:to_s).map(&:downcase).map(&:strip).uniq).size.times { rs = rs + 10}

    rs
  end

  def last_replied_at lead
    self.lead_replies.conversations_for(lead, self).order('created_at DESC').first.try(:created_at)
  end

  def mark_replies_read! lead, curr_user
    LeadReply.conversations_for(lead, self).each do |reply|
      if reply.target_lead.user_id == curr_user.id
        reply.read! 
      end
    end
  end

  def unread_replies
    leadid = self.id
    # matchedleadids = LeadGeneration.match_against_with_live_leads(self).map(&:id)
    matchedleadids = LeadGeneration.top_level_match(self).map(&:id)

    LeadReply.includes(:target_lead).includes(:original_lead).where{(target_lead.id.eq leadid) & (original_lead.id.in matchedleadids) & (read.eq false)}
  end

  def unread_replies_count
    self.unread_replies.all.count
  end

  def unread_replies_count_label
    pluralize(self.unread_replies.all.count, 'unread reply')
  end


  def unread_replies_for_particular_lead lead
    selfid = self.id
    LeadReply.conversations_for(lead, self).where{(target_lead.id.eq selfid) & (read.eq false)}
  end

  def cal_ranking!
    rs = LeadReply.related_to_lead(self).count
    mul = Recommend.where(:recommendable_id => self.user.try(:profile).try(:id)).count

    self.rank = rs * (mul + 1)
    self.save(:validate => false)
  end

  # after_create :create_notifications_for_matched_users
  # after_create does not work.. please call this method manually
  # -----------------------------------------------------------------
  def create_notifications_for_matched_users
    if self.is_live?
      matched_leads = LeadGeneration.top_level_match(self).all
      if matched_leads.size > 0
        Notification.create(:lead_generation => self, :user => self.user)
      end

      matched_leads.map(&:user).uniq.each do |user|
        Notification.create(:lead_generation => self, :user => user)
      end
    end
    true
  end

  def prev_latest_reply lead
    last_orinal_lead = LeadReply.conversations_for(lead, self).order('lead_replies.created_at DESC').first.try(:original_lead)
    if last_orinal_lead
      return LeadReply.conversations_for(lead, self).where(:target_lead_id => last_orinal_lead.id).order('lead_replies.created_at DESC').first
    end
    nil
  end

  def get_subject
    self.subject || 'no subject'
  end

  def last_replied_by? lead, user
    latest_reply = LeadReply.conversations_for(lead, self).order('lead_replies.created_at DESC').first
    return true if latest_reply && latest_reply.original_lead.user == user
    false
    # (
    #   curr_user == self.user && last_replied_by_owner?(thread_usr)
    # ) || (
    #   curr_user != self.user && !last_replied_by_owner?(thread_usr)
    # )
  end

  def is_providing?
    self.lg_type == 'providing'
  end

  def is_live?
    self.lg_state == 'live'
  end
  def is_live
    self.is_live?
  end

  def live!
  	self.lg_state = 'live'
  	self.save(:validate => false)
  end

  def pause!
  	self.lg_state = 'pause'
  	self.save(:validate => false)
  end
end




