class QuickMessageController < ApplicationController
  def index
    @qms = current_user.quick_messages
    
    render :json => @qms.to_json
  end

  def create
    @qm = QuickMessage.create!(:body => params[:body], :user_id => current_user.id)
    
    render :json => @qm.to_json
  end

  def update
    @qm = QuickMessage.find(params[:id])
    @qm.body = params[:body]
    @qm.save
    
    render :json => "ok".to_json
  end

  def destroy
    @qm = QuickMessage.find(params[:id])
    
    current_user.quick_messages.delete(@qm)
    @qm.destroy
    
    render :json => "ok".to_json
  end

end
