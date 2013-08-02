class MembersController < ApplicationController
  include UsersHelper

  def index
    ids = current_user.users.map(&:id)

    @members = User.where{id.not_in ids}.order("created_at DESC").all
    respond_to do |format|
      format.html
      format.json { render :json => @members.to_json(user_json) }
    end
  end
end
