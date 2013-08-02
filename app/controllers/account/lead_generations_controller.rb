class Account::LeadGenerationsController < ApplicationController
  include ActionView::Helpers::TextHelper
  include RepliesHelper
  before_filter :authenticate_user!
  before_filter :check_profile

  def new
  end

  def lead_to_json lead
    lead.to_json(:methods => [:is_live, :unread_replies_count, :unread_replies_count_label], :include => {:area => {}, :sub_area => {:only => :name}, :service => {:only => :name}, :keywords => {:only => :name}, :user => {:methods => [:imageUrlMedium, :name]}})
  end

  def unread_replies
    @lead = current_user.lead_generations.find(params[:id])
    @match = LeadGeneration.find(params[:match_id])

    unread = @lead.unread_replies_for_particular_lead(@match).count

    render :json => {:count => unread, :label => pluralize(unread, 'unread replies')}
  end

  def index
    @body_class = 'grey_bg'
    @leads = current_user.lead_generations

    respond_to do |format|
      format.json { return render(:json => lead_to_json(@leads)) }
      format.html
    end
  end

  def fetch_replies
    @lead = current_user.lead_generations.find(params[:id])
    @target_lead = LeadGeneration.find(params[:match_id])

    @replies = LeadReply.conversations_for(@lead, @target_lead).order('lead_replies.created_at ASC')

    render :json => reply_to_json(@replies)
  end

  def show
    @lead = current_user.lead_generations.find(params[:id])
    @target_lead = LeadGeneration.find(params[:lead_id])

    @replies = LeadReply.conversations_for(@lead, @target_lead).order('lead_replies.created_at ASC')

    @replies.where(:target_lead_id => @lead.id).each do |reply|
      reply.read!
    end
  end

  def matched
    @lead = current_user.lead_generations.find(params[:id])
    
    @matched_leads = LeadGeneration.top_level_match(@lead).order('rank DESC')

    # sort matches with self-rank & keywords rank added up => lead.rank + lead.keyword1.rank + lead.keyword2.rank
    # ===========================================================================================================
    rs = {}
    @matched_leads.each do |lead|
      rs[lead] = lead.keyword_ranking(@lead) + (lead.rank || 0)
    end
    @matched_leads = rs.sort_by {|k, v| v}.reverse.collect {|ele| ele[0]}

    respond_to do |format|
      format.html {}
      format.json { render :json => lead_to_json(@matched_leads) }
    end
  end

  def create
    @lead_generation = current_user.lead_generations.build(params[:lead_generation])

    if params[:from_sign_up]
      profile = current_user.profile
      profile.step = 3
      profile.save(:validate => false)
      if profile.active?
        profile.user.first_time_login!
      end
    end

    if @lead_generation.save && @lead_generation.create_notifications_for_matched_users

      if params[:from_sign_up]
        return redirect_to root_path
      else

        respond_to do |format|
          format.json {return render(:json => lead_to_json(@lead_generation))}
          format.html {return redirect_to account_lead_generations_path, :notice => 'Your Lead created successfully!'}
        end
      end
    else
      return render :json => @lead_generation.errors, :status => :unprocessable_entity
    end

  end

  def update
    @lead_generation = current_user.lead_generations.find(params[:id])
    
    if @lead_generation.update_attributes(params[:lead_generation])
      render :partial => 'lead_generations/show', :locals => {:lead_generation => @lead_generation}, :status => :success, :content_type => 'text/html'
    else
      render :json => @lead_generation.errors, :status => :unprocessable_entity
    end
  end

  def live
    @lead_generation = current_user.lead_generations.find(params[:id])
    @lead_generation.live!

    render :nothing => true, :state => 200, :content_type => 'text/html'
  end

  def top_level_match
    @lead_generation = current_user.lead_generations.find(params[:id])
    matches = LeadGeneration.top_level_match(@lead_generation)
    count = matches.all.size
    render :json => {:count => count, :match_label => pluralize(count, 'match')}.to_json
  end

  def pause
    @lead_generation = current_user.lead_generations.find(params[:id])
    @lead_generation.pause!

    render :nothing => true, :state => 200, :content_type => 'text/html'
  end

  
  def destroy
    @lead_generation = current_user.lead_generations.find(params[:id])
    @lead_generation.destroy

    render :nothing => true, :state => 200, :content_type => 'text/html'
  end
end