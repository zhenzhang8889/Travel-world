class CurrusersController < ApplicationController
  def show
    render :json => current_user.to_json(:only => :id)
  end
end