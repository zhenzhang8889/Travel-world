class Account::FriendActsController < ApplicationController
  def index
    @usracts = Usract.where(:user_id => current_user.users.map(&:id)).order('created_at DESC')
    render :json => @usracts.to_json(:include => {:user => {:methods => :name}}), :status => :ok
  end
end