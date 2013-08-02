class Account::RefertosController < ApplicationController
  include RefertosHelper
  # def index 
  #   # @refer_tos = Referto.where(:to_id => current_user.id).order('created_at DESC')
  #   @refer_tos = Referto.all

  #   render :json => @refer_tos.to_json(referto_json)
  # end

  def posts
    @refer_tos = Referto.posts
    render :json => @refer_tos.to_json(referto_post_json)
  end

  def members
    @refer_tos = Referto.members
    render :json => @refer_tos.to_json(referto_user_json)
  end

  def create
    # puts params[:post_id]

    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])

    if params[:type] == '0'
      @referable = @post.user
    else
      @referable = @post
    end

    @referto = Referto.new(:from => current_user, :to => @user, :referable => @referable)
    if @referto.save
      render :nothing => true, :status => :created
    else
      render :nothing => true, :status => :unprocessable_entity
    end
  end
end
