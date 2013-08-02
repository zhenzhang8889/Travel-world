class Admin::Level2AdminsController < Admin::BaseController

  before_filter :find_level2_admin, :only => [:edit, :update]
  
  def index
    @level2_admin_users = User.where(:is_level2_admin => true)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @level2_admin_users }
    end
  end

  def new
    @level2_admin_user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @level2_admin_user }
    end
  end

  def edit
  end

  def create
    @level2_admin_user = User.new_from_params(params[:user])
    @level2_admin_user.generate_random_password
    @level2_admin_user.is_level2_admin = true

    respond_to do |format|
      if @level2_admin_user.save
        format.html { redirect_to "/admin/level2_admins" , notice: 'User was successfully created.' }
        format.json { render json: @level2_admin_user, status: :created, location: @level2_admin_user }
      else
        format.html { render action: "new" }
        format.json { render json: @level2_admin_user.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    @level2_admin_user.assign_attributes_from_params(params[:user])
    respond_to do |format|
      if @level2_admin_user.valid? and @level2_admin_user.save
        format.html { redirect_to "/admin/level2_admins", notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @level2_admin_user.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @level2_admin_user = User.find(params[:id])
    @level2_admin_user.destroy

    respond_to do |format|
      format.html { redirect_to level2_admin_users_url }
      format.json { head :no_content }
    end
  end

  private

  def find_level2_admin
    @level2_admin_user = User.find(params[:id])
    redirect_to "/admin/level2_admins" unless @level2_admin_user.is_level2_admin
  end

end
