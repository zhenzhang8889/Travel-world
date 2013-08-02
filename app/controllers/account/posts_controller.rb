class Account::PostsController < ApplicationController
  include PostsHelper

  def index
    @posts = Post.where(:user_id => current_user.users.map(&:id) + [current_user.id]).order('created_at DESC')
    render :json => post_to_json(@posts), :status => :ok
  end

  def self
    @posts = current_user.posts.order('created_at DESC')
    render :json => post_to_json(@posts), :status => :ok
  end

  def create
    if (params[:post] || {})[:data].blank?
      params[:post][:data] = nil
    end

    @post = current_user.posts.build(params[:post])
    if @post.save
      render :json => post_to_json(@post), :status => :created
    else
      render :nothing => true, :status => :unprocessable_entity
    end
  end
end
