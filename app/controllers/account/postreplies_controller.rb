class Account::PostrepliesController < ApplicationController
  include UsersHelper

  def create
    @post = Post.where(:user_id => current_user.users.map(&:id) + [current_user.id]).find(params[:post_id])

    @post_reply = @post.postreplies.build(params[:postreply])
    @post_reply.user = current_user

    if @post_reply.save
      # user_json is from UserHelper
      render :json => @post_reply.to_json(:include => {:user => user_json}), :status => :created
    else
      render :json => @post_reply.errors, :status => :unprocessable_entity
    end
  end
end
