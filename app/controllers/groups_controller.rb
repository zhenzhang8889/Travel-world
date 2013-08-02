class GroupsController < ApplicationController
  def index
    @groups = current_user.groups
    
    respond_to do |format|
      format.json { render :json => @groups.to_json(:include => {:users => { :methods => [:imageUrlMedium, :imageUrlSmall, :categoryName ]} }) }
    end
  end

  def simpleidx
    @groups = current_user.groups.order('created_at ASC')
    respond_to do |format|
      format.json { render :json => @groups.to_json }
    end
  end

  def create
    group = current_user.groups.where(:name => params[:group_name].blank? ? "Click to change me!!" : params[:group_name], :user_id => current_user.id, :traveler => params[:traveler]).first
    if group.nil?
      group = current_user.groups.create(:name => params[:group_name].blank? ? "Click to change me!!" : params[:group_name], :user_id => current_user.id, :traveler => params[:traveler])
    end
    render :json => group.to_json(:include => {:users => { :methods => [:imageUrlMedium, :imageUrlSmall, :categoryName ]} })
  end

  def update
    group = current_user.groups.find(params[:id])
    group.name = params[:name]
    group.save
    
    render :json => "ok".to_json
  end

  def destroy
    group = current_user.groups.find(params[:id])
    group.destroy
    
    render :json => "ok".to_json
  end

  def addUser
    group = current_user.groups.find(params[:id])
    user = User.find(params[:user_id])
    group.users << user

    render :json => "ok".to_json
  end

  def removeUser
    group = current_user.groups.find(params[:id])
    user = group.users.find(params[:user_id])
    group.users.delete(user)
    render :json => "ok".to_json
  end
  
  def toAdd
    group = current_user.groups.find(params[:id])
    ids = group.users(:select => :id).collect(&:id)
    ids << current_user.id
    users = User.where("id NOT IN (?) AND traveler= ?", ids, group.traveler)
    
    render :json => users.to_json(:methods => [:imageUrlMedium, :imageUrlSmall, :categoryName ])
  end
end
