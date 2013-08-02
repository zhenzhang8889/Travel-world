class ApplicationController < ActionController::Base

  before_filter :authenticate_user!
  before_filter :set_user_time_zone  
  before_filter :check_profile
  protect_from_forgery

  def check_profile
    if user_signed_in? && request.get?
      profile = current_user.profile || current_user.create_profile
      if !profile.active?
        if profile.step >= 3
          redirect_to edit_account_profile_path(:step => 2)
          return false
        else
          redirect_to edit_account_profile_path(:step => profile.step + 1)
          return false
        end
      end
    end
  end

  private
  def set_user_time_zone
    Time.zone = current_user.profile.time_zone if user_signed_in? && current_user.profile.try(:time_zone)
  end


  def after_sign_out_path_for(resource)
    if resource == :admin
      return admin_root_path
    end
    root_path
  end
end
