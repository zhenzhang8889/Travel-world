class ContactsController < ApplicationController
  include UsersHelper

  def index
    if params[:group_id].blank?
      @users = current_user.users.uniq
    else
      @group = current_user.groups.find(params[:group_id])
      @users = @group.users
    end

    respond_to do |format|
      format.json { render :json => @users.to_json(user_json)}
    end
  end

  def create
    @user = User.find(params[:user_id])

    @group = current_user.groups.where(:traveler => false).first || current_user.groups.create(:traveler => false)

    if Contact.create(:user => @user, :group => @group)
      return render :nothing => true, :status => :created
    else
      return render :nothing => true, :status => :unprocessable_entity
    end
  end

  def destroy
    @contact = current_user.contacts.find_by_user_id(params[:user_id])
    
    if @contact.nil? || @contact.destroy
      return render :nothing => true, :status => :ok
    else
      return render :nothing => true, :status => :unprocessable_entity
    end
  end

  def all
    if current_user.users.uniq.size > 0
      @users = User.where("id not in (?)", current_user.users.uniq.map(&:id))
    else
      @users = User.all
    end

    respond_to do |format|
      format.json { render :json => @users.to_json(user_json)}
    end
  end
end