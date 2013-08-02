class UsersController < ApplicationController
  
  def update_score
    if (badge = Badge.find(params[:task_id]))
      if !current_user.completed_badge_ids.include? badge.id and params[:decrease].blank?
        user_completed_badge = UserCompletedBadge.new
        user_completed_badge.user_id = current_user.id
        user_completed_badge.badge_id = badge.id
        user_completed_badge.note = params[:task_note]
        user_completed_badge.save
      elsif params[:decrease]
        user_completed_badge = UserCompletedBadge.find(:first, :conditions =>
            { :badge_id => badge.id, :user_id => current_user.id } )
        user_completed_badge.destroy if user_completed_badge
      end
    end
    render :json => "ok".to_json
  end

  def update_task_note
    user_completed_badge = UserCompletedBadge.find(:first,
      :conditions => { :user_id => current_user.id, :badge_id => params[:task_id]} )
    if user_completed_badge
      user_completed_badge.note = params[:task_note]
      user_completed_badge.save
    end
    render :json => "ok".to_json
  end
  
  
  
end