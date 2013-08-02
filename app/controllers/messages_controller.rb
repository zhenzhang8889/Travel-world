class MessagesController < ApplicationController
  def index
    # @contact = User.find(params[:contact_id])
    # mess_thread_ids = @contact.message_threads.uniq.map(&:id) & current_user.message_threads.uniq.map(&:id)
    # = Message.where(:message_thread_id => mess_thread_ids)
    @mess_thread = current_user.message_threads.find(params[:thread_id])
    @messages = @mess_thread.messages.order('created_at ASC').last(20)

    respond_to do |format|
      format.html
      format.json { render :json => @messages.to_json(:methods => [:auth_name, :related_date])}
    end
  end

  def upload
    @new_message = Message.new(:message_thread_id => params[:message_thread_id], :user_id => current_user.id)
    render :layout => 'frame_layout'
  end
  
  def uploaded
    @new_message = Message.create!(params[:message])

    PrivatePub.publish_to "/" + current_user.id.to_s,
      "application.setAttachId(#{@new_message.id}, #{@new_message.message_thread_id});"
    render :layout => 'frame_layout'
  end

  def destroy
    @message = Message.find(params[:id])
    thread_id = @message.message_thread_id
    @message.destroy
    
    PrivatePub.publish_to "/" + current_user.id.to_s,
      "application.removeAttachId(#{thread_id});"
    
    redirect_to "/upload/" + thread_id.to_s
  end
  
  def create
    # if params[:target_user_id]
      # target_user = User.find(params[:target_user_id])
    #   mess_thread_ids = target_user.message_threads.uniq.map(&:id) & current_user.message_threads.uniq.map(&:id)
    #   if mess_thread_ids.blank?
      # new_mess_thread = MessageThread.createnew(current_user, target_user)
        # mess_thread_ids = [new_mess_thread.id]
    #   end

      # params[:message_thread_id] = new_mess_thread.id
    # end

    mt = MessageThread.find(params[:message_thread_id].to_i)


    mt.thread_users.where(:archived => true, :deleted => false).each do |tu|
      PrivatePub.publish_to "/" + tu.user_id.to_s,
          "application.addThread(new Thread(JSON.parse(unescape(' \
            #{ URI.escape(String.new(mt.to_json.to_s)).gsub(/'/,"\%27") }'))), \
            #{ tu.user_id == current_user.id ? tu.user_id.to_s : current_user.id });"
      tu.archived = false
      tu.save
    end

    if params[:attach_id] == "0"
      @message = Message.create!(:content => URI.unescape(params[:content]), :user_id => current_user.id, 
                                 :message_thread_id => params[:message_thread_id], :ack => params[:ack])
    else
      @message = Message.find(params[:attach_id].to_i)
      @message.content = URI.unescape(params[:content])
      @message.ack = params[:ack]
      @message.save
    end

    @message.message_thread.thread_users.where(:archived => false, :deleted => false).each do |u|
      puts "/" + u.user_id.to_s
      PrivatePub.publish_to "/" + u.user_id.to_s,
        "application.addMessage(new Message(JSON.parse(unescape(' \
          #{ URI.escape(@message.to_json({:include => :user, :methods => :getAttach}).to_s).gsub(/'/,"\%27") }'))), \
          #{ @message.message_thread_id }); scrollDown(#{ @message.message_thread_id.to_s });"
      
      PrivatePub.publish_to "/mobile/#{u.user_id}", @message.to_json(:methods => [:auth_name, :related_date])

      if u.user_id != current_user.id
        PrivatePub.publish_to "/" + u.user_id.to_s,
          "application.sendACK(#{ @message.message_thread_id },#{ @message.id })"
      end
    end

    render :json => "ok".to_json
  end
end
