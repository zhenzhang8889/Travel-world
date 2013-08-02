class Admin::BaseController < ActionController::Base
  before_filter :authenticate_admin!
  layout 'admins'
end
