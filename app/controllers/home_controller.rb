class HomeController < ApplicationController
  include UsersHelper

  def index
  end
  
  def knockout
    redirect_to "/level2_admin" if current_user.is_level2_admin
    category_badges = CategoryBadge.all
    localtourism = category_badges.first
    ecotourism = category_badges.last

    @localtask = Badge.find(:all, :conditions => ["is_active = ? and category_badge_id = ?", true, localtourism.id])
    @ecotask = Badge.find(:all, :conditions => ["is_active = ? and category_badge_id = ?", true, ecotourism.id])

    @localpoint = Badge.count_point(@localtask)
    @ecopoint = Badge.count_point(@ecotask)

    @user_completed_badge_ids = current_user.completed_badge_ids

    @user_localtourism_point = current_user.count_tasks_point(@localtask, @localpoint, @user_completed_badge_ids)
    @user_ecotourism_point = current_user.count_tasks_point(@ecotask, @ecopoint, @user_completed_badge_ids)

    @total_visits = current_user.user_visit_histories.count
    @visits_by_services = current_user.user_visit_histories.group(:service_id).count
    @visits_by_country = current_user.user_visit_histories.group(:country).count
  end

  def groups
    @groups = current_user.groups
    
    respond_to do |format|
      format.json { render :json => @groups.to_json(:include => {:users => { :methods => [:imageUrlMedium, :imageUrlSmall, :categoryName ]} }) }
    end
  end
  
  def allUsers
    render :json => User.all.to_json(user_json)
  end
end
