class Level2Admin::BaseController < ActionController::Base
  before_filter :authenticate_level2_admin!
  layout 'level2_admin'

  def authenticate_level2_admin!
    if !current_user || !current_user.is_level2_admin
      redirect_to "/"
    end
  end
  
end
