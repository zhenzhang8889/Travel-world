class MessageThreadController < ApplicationController

  def list
    @user = User.find(params[:user_id])
    @threads = current_user.message_threads.where(:id => @user.message_threads.map(&:id)).order("created_at DESC")

    respond_to do |format|
      format.json {render :json => @threads.to_json(:only => [:id, :subject], :methods => :formated_date)}
      format.html
    end
  end

  def update
    # update your model
    @thread = MessageThread.find(params[:id])
    @thread.update_attributes!(params[:message_thread])

    if request.xhr?
      render :json => "ok".to_json
    else
      redirect_to(@thread, :notice => 'Thread was successfully updated.')
    end
  end

  def index
    @threads = current_user.message_threads.where("thread_users.archived = ? AND thread_users.deleted = ?", false, false)

    render :json => @threads.to_json.html_safe.to_s
  end

  def show
    @thread = MessageThread.find(params[:id])
    @user = @thread.users.first

    html = render_to_string(:action => "show.html.erb", :formats => [:html])
    kit = PDFKit.new(html)
    send_data(kit.to_pdf, :filename => @thread.subject + "_" +Time.now.to_s, :type => 'application/pdf')
    return
  end

  def change_subject
    @thread = MessageThread.find(params[:id])
    @thread.subject = params[:subject]
    @thread.save!

    @thread.thread_users.where(:deleted => false, :archived => false).each do |tu|
      if tu.user_id != current_user.id
        PrivatePub.publish_to "/" + tu.user_id.to_s,
          "application.changeSubject(#{ @thread.id.to_s }, '#{ @thread.subject }');"
      end
    end
    render :json => "Ok"
  end
  
  def create
    @thread = MessageThread.new
    @thread.subject = "Click to change me!"
    @thread.users << current_user
    @thread.users << User.find(params[:receiver_id])
    @thread.save
    
    @thread.users.each do |u|
      PrivatePub.publish_to "/" + u.id.to_s,
          "application.addThread(new Thread(JSON.parse(' \
            #{@thread.to_json.html_safe.to_s }')), \
            #{ u.id == current_user.id ? params[:receiver_id].to_s : current_user.id });"
    end
    render :json => @thread.to_json.html_safe.to_s
  end
  
  def ack
    message = Message.find(params[:message_id])
    if message.status.nil? or message.status.empty?
      message.status = current_user.id
    else
      if !message.status.split(",").include?("#{current_user.id}")
        message.status = message.status + ",#{ current_user.id }"
      end
    end
    message.save!

    PrivatePub.publish_to "/" + message.user_id.to_s,
        "application.receiveACK(#{ params[:id] }, #{ params[:message_id] }, #{ '"' + current_user.id.to_s + '"' });"

    render :json => "ok".to_json
  end
  
  def acknowledgement
    message = Message.find(params[:message_id])
    if message.acked.nil? or message.acked.empty?
      message.acked = current_user.id
    else
      if !message.acked.split(",").include?("#{current_user.id}")
        message.acked = message.acked + ",#{ current_user.id }"
      end
    end
    message.save!

    PrivatePub.publish_to "/" + message.user_id.to_s,
        "application.receiveAcknowledgement(#{ params[:id] }, #{ params[:message_id] }, #{ current_user.id });"

    render :json => "ok".to_json
  end

  def archive_thread
    thread_user = current_user.thread_users.where(:message_thread_id => params[:id]).first
    thread_user.archived = true
    thread_user.save

    render :json => "ok".to_json
  end

  
  def destroy_thread
    thread_user = current_user.thread_users.where(:message_thread_id => params[:id]).first
    thread_user.deleted = true
    thread_user.save

    ThreadUser.where("thread_users.message_thread_id = ? AND thread_users.archived = ? AND thread_users.deleted = ?", 
                                    params[:id], false, false).each do |u|
      PrivatePub.publish_to "/" + u.user_id.to_s, "application.removePerson(#{ params[:id] }, #{ current_user.id });"
    end

    render :json => "ok".to_json
  end
end
