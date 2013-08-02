# == Schema Information
#
# Table name: lead_replies
#
#  id                 :integer          not null, primary key
#  lead_generation_id :integer
#  user_id            :integer
#  target_user_id     :integer
#  body               :text
#  read               :boolean          default(FALSE)
#  del_by_user        :boolean          default(FALSE)
#  del_by_target_user :boolean          default(FALSE)
#  original_lead_id   :integer
#  target_lead_id     :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class LeadReply < ActiveRecord::Base
  attr_accessible :original_lead, :target_lead, :body

  belongs_to :original_lead, :class_name => 'LeadGeneration'
  belongs_to :target_lead, :class_name => 'LeadGeneration'

  scope :conversations_for, lambda {|lead1, lead2|
    includes(:original_lead, :target_lead).where{
      ((original_lead.id.eq lead1.id) & (target_lead.id.eq lead2.id)) | ((original_lead.id.eq lead2.id) & (target_lead.id.eq lead1.id))
    }
  }

  scope :unread_for, lambda { |lead|
    includes(:target_lead).where{(target_lead.id.eq lead.id) & (read.eq false)}
  }

  scope :related_to_lead, lambda {|lead|
    includes(:original_lead, :target_lead).where{
      (original_lead.id.eq lead.id) | (target_lead.id.eq lead.id)
    }
  }

  scope :related_to, lambda {|u|
    includes(:original_lead, :target_lead).where{(original_lead.user_id.eq u.id) | (target_lead.user_id.eq u.id)}
  }

  def read!
    self.read = true
    self.save(:validate => false)
  end

  def mark_del! usr
    if usr == self.original_lead.user
      self.del_by_user = true
    end

    if usr == self.target_lead.user
      self.del_by_target_user = true
    end

    self.save(:validate => false)
  end
end

