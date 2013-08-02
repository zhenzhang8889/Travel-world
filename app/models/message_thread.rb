# == Schema Information
#
# Table name: message_threads
#
#  id         :integer          not null, primary key
#  subject    :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class MessageThread < ActiveRecord::Base
  has_many :users, :through => :thread_users
  has_many :thread_users
  has_many :messages, :dependent => :destroy

  def as_json(options)
    if options.blank?
      super(:include => {:users => { :methods => [:imageUrlMedium, :imageUrlSmall, :categoryName ]}, :messages => { :include => :user, :methods => :getAttach }})
    else
      super(options)
    end
  end

  def self.createnew u1, u2
    @thread = MessageThread.new
    @thread.subject = Time.now.to_s
    @thread.users << u1
    @thread.users << u2
    @thread.save

    @thread.users.each do |u|
      PrivatePub.publish_to "/" + u.id.to_s,
          "application.addThread(new Thread(JSON.parse(' \
            #{@thread.to_json.html_safe.to_s }')), \
            #{ u.id == u1.id ? u2.id.to_s : u1.id });"
    end
    @thread
  end

  def formated_date
    self.updated_at.strftime('%F %T')
  end
end
