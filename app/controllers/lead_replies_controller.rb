class LeadRepliesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :check_profile

  include RepliesHelper
  def create
    @lead = current_user.lead_generations.find(params[:lead_reply][:original_lead_id])
    @target_lead = LeadGeneration.find(params[:lead_reply][:target_lead_id])
    @reply = LeadReply.new(
      :original_lead => @lead,
      :target_lead => @target_lead,
      :body => params[:lead_reply][:body]
    )

    # @reply = current_user.lead_replies.build(params[:lead_reply])

    if @reply.save
      return render :json => reply_to_json(@reply)
      # render :partial => 'lead_replies/show', :locals => {:reply => @reply}, :status => 200, :content_type => 'text/html'
    else
      render :json => @reply.errors, :status => :unprocessable_entity
    end
  end

end
