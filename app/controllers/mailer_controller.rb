class MailerController < ApplicationController
 
  def mailuser
    @id = params[:id]
    @users = User.find(
      :all,
      :order => 'created_at DESC',
      :limit => 10
    )
    @received_messages = Chatting.find(
      :all,
      :order => 'created_at DESC',
      :conditions => "recipient_id = '#{current_user.id}'",
      :limit => 10
      ) 
    @user = current_user
    @area=Area.find(1)
    @location=Service.find(1)
    respond_to do |format|
      format.js
    end
  end
  
  def mailinbox
    @id = params[:id]
    
    @users = User.find(
      :all,
      :order => 'created_at DESC',
      :limit => 10
    )
    @received_messages = Chatting.find(
      :all,
      :order => 'created_at DESC',
      :conditions => ["(sender_id=? or sender_id=?) and (recipient_id=? or recipient_id=?)",sender_id,5,sender_id,5],
      :limit => 5
      ) 
    @user = current_user
    @area=Area.find(1)
    @location=Service.find(1)
    
    
    respond_to do |format|
      format.js
    end
  end
  
  def mailnew
    mailbody = params[:mailbody]
    
    @replyid = params[:id]
    
    @mailreply = Chatting.find(
      :all,
      :conditions => ["body=?",mailbody],
      ) 
      
    respond_to do |format|
      format.js
    end
  end
   
  def recipientid
    @id = params[:id]
    respond_to do |format|
      format.js
    end
  end
     
   
  def sendmail
    body = params[:body]
    subject = params[:subject]      
    reciever  = params[:senderid]       
    sender_id = params[:recipients]
    message = Chatting.new
    message.subject = subject
    message.body = body
    message.sender_id = sender_id
    message.recipient_id = reciever.to_i
    message.save
    
    bigmessage = Message.new
    bigmessage.subject = subject
    bigmessage.body = body
    bigmessage.sender_id = sender_id
    bigmessage.recipient_id = reciever.to_i
    bigmessage.save
    
    @id = params[:id]
    @received_messages = Chatting.find(
      :all,
      :order => 'created_at DESC',
      :conditions => ["(sender_id=? or sender_id=?) and (recipient_id=? or recipient_id=?)",sender_id,5,sender_id,5],
      :limit => 5
      ) 
    @area=Area.find(1)
    @location=Service.find(1)
    respond_to do |format|   
      format.js
    end
  end
  
  def mailnotification
    @id = params[:id]
    
    @users = User.find(
      :all,
      :order => 'created_at DESC',
      :limit => 10
    )
    @received_messages = Message.find(
      :all,
      :order => 'created_at DESC',
      :conditions => ["(sender_id=? or sender_id=?) and (recipient_id=? or recipient_id=?)",sender_id,5,sender_id,5],
      :limit => 5
      ) 

    @received_messages.each do |message|
      message.read_at = Time.now
      message.save
    end
    @received_messages = Chatting.find(
      :all,
      :order => 'created_at DESC',
      :conditions => ["(sender_id=? or sender_id=?) and (recipient_id=? or recipient_id=?)",sender_id,5,sender_id,5],
      :limit => 5
      ) 

    @received_messages.each do |message|
      message.read_at = Time.now
      message.save
    end

    @received_messages = Chatting.find(
      :all,
      :order => 'created_at DESC',
      :conditions => ["(sender_id=? or sender_id=?) and (recipient_id=? or recipient_id=?)",sender_id,5,sender_id,5],
      :limit => 5
      )
    @user = current_user
    @area=Area.find(1)
    @location=Service.find(1)
    
    
    respond_to do |format|
      format.js
    end
    
  end
  
  def leadmessage
    @id = params[:id]
    
    @users = User.find(
      :all,
      :order => 'created_at DESC',
      :limit => 10
    )
    @received_messages = Chatting.find(
      :all,
      :order => 'created_at DESC',
      :conditions => ["(sender_id=? or sender_id=?) and (recipient_id=? or recipient_id=?)",sender_id,5,sender_id,5],
      :limit => 5
      ) 
    @user = current_user
    @area=Area.find(1)
    @location=Service.find(1)
    @mailbody = params[:mailbody]
    @leadmsg=Chatting.find(
      :all,
      :conditions => "body = '#{@mailbody}'"
    )
    
    @leadmsg.each do |message|
      message.read_at = Time.now
      message.save
    end
    
    @leadmsg=Message.find(
      :all,
      :conditions => "body = '#{@mailbody}'"
    )
     @leadmsg.each do |message|
      message.read_at = Time.now
      message.save
    end
    
    @leadmsg=Chatting.find(
      :all,
      :conditions => "body = '#{@mailbody}'"
    )
     respond_to do |format|   
      format.js
    end
  end
    
    
    private
      def sender_id
        current_user.id.to_i
      end 
    
    private
      def messagecreatedtime(msg)
        msg[0, 19]
      end
     
end

