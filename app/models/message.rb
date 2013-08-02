# == Schema Information
#
# Table name: messages
#
#  id                  :integer          not null, primary key
#  content             :text
#  created_at          :datetime
#  updated_at          :datetime
#  ack                 :boolean
#  status              :string(255)
#  message_thread_id   :integer
#  user_id             :integer
#  acked               :string(255)
#  attach_file_name    :string(255)
#  attach_content_type :string(255)
#  attach_file_size    :integer
#  attach_updated_at   :datetime
#

class Message < ActiveRecord::Base
  include ActionView::Helpers::DateHelper
  attr_accessible :content, :ack, :status, :message_thread_id, :user_id, :acked, :attach


  belongs_to :message_thread
  belongs_to :user

  has_attached_file :attach,
                    :storage => Rails.env.production? ? :s3 : :filesystem,
                    :s3_credentials => "#{Rails.root}/config/s3.yml"

  def auth_name
    self.user.try(:full_name)
  end

  def related_date
    "#{time_ago_in_words(self.created_at)} ago"
  end

  def userSentAcknowledgement
    self.status.split(",").include?(current_user.id.to_s)
  end

  def receiveAllsendAcknowledgement(ar_ids)
    if ar_ids.nil?
      return false
    else
      ids = ar_ids.split(",")
      users_count = self.message_thread.users.count

      self.message_thread.users.count{|u| ids.include?(u.id.to_s)} == users_count
    end
  end

  def getStatus(current_user)
    status = ""
    if self.ack
      if current_user.id != self.user_id
        if (!self.userSentAcknowledgement)
          status = " Acknowledgement Required"
        else
          status = " Acknowledgement Sent"
        end
      else
        if (self.receiveAllsendAcknowledgement(self.acked))
          status = " Acknowledgement Received"
        else
          status = " Acknowledgement Sent"
        end
      end
    else
      allConfirmedBack = self.receiveAllsendAcknowledgement(self.status)
      if current_user.id != self.user_id
        status = " Received"
      else
        if !allConfirmedBack
          status = " Pending"
        else
          status = " Delivered";
        end
      end
    end

    status
  end

  def getAttach
    if self.attach_file_name.nil? or self.attach_file_name == ""
      return ""
    else  
      return self.attach.url
    end
  end
end
