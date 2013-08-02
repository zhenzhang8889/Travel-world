class Level2Admin::UsersController < Level2Admin::BaseController
  # GET /level2_admin/users
  # GET /level2_admin/users.json
  def index
    @level2_admin_users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @level2_admin_users }
    end
  end

  # GET /level2_admin/users/1
  # GET /level2_admin/users/1.json
  def show
    @level2_admin_user = User.find(params[:id])
    if @level2_admin_user and @level2_admin_user.profile.blank?
      @profile = Profile.new
      @address = Address.new
    else
      @profile = @level2_admin_user.profile
      @address = @profile.address
    end
    
    

    respond_to do |format|
      format.html { render :layout => "application" }
      format.json { render json: @level2_admin_user }
    end
  end

  # GET /level2_admin/users/new
  # GET /level2_admin/users/new.json
  def new
    @level2_admin_user = User.new
    @level2_admin_user.profile = Profile.new
    @level2_admin_user.profile.address = Address.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @level2_admin_user }
    end
  end

  # GET /level2_admin/users/1/edit
  def edit
    @level2_admin_user = User.find(params[:id])
    if @level2_admin_user.profile.blank?
      @profile = Profile.new
      @level2_admin_user.profile = @profile
    else
      @profile = @level2_admin_user.profile
    end
    @address = @profile.address.blank? ? Address.new : @profile.address
  end

  # POST /level2_admin/users
  # POST /level2_admin/users.json
  def create
    params[:profile][:address] = params[:address]
    @level2_admin_user, @profile = User.new_from_params_with_profile(params[:user], params[:profile])
    @level2_admin_user.generate_random_password

    respond_to do |format|
      if @level2_admin_user.valid? and @profile.valid? and @profile.address.valid?
        @level2_admin_user.save
        @profile.user_id = @level2_admin_user.id
        @profile.save
        @profile.address.save

        format.html { redirect_to level2_admin_users_path , notice: 'User was successfully created.' }
        format.json { render json: @level2_admin_user, status: :created, location: @level2_admin_user }
      else
        format.html { render action: "new" }
        format.json { render json: @level2_admin_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /level2_admin/users/1
  # PUT /level2_admin/users/1.json
  def update
    @level2_admin_user = User.find(params[:id])

    @profile = @level2_admin_user.profile.blank? ? Profile.new : @level2_admin_user.profile
    @level2_admin_user.assign_attributes_from_params(params[:user])
    @profile.address = Address.new if @profile.address.blank?
    @profile.address.attributes = params[:address]
    @profile.assign_attributes_from_params(params[:profile])
    @prov_avatar = ProfAvatar.new(params[:prov_avatar])
    respond_to do |format|
      if @level2_admin_user.valid? and @profile.valid? and @profile.address.valid?
        @level2_admin_user.save
        @profile.user_id = @level2_admin_user.id
        @profile.save
        @profile.address.save
        @prov_avatar.profile_id = @profile.id
        @prov_avatar.save
        format.html { redirect_to level2_admin_users_path, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @level2_admin_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /level2_admin/users/1
  # DELETE /level2_admin/users/1.json
  def destroy
    @level2_admin_user = User.find(params[:id])
    @level2_admin_user.destroy

    respond_to do |format|
      format.html { redirect_to level2_admin_users_url }
      format.json { head :no_content }
    end
  end

  def logout
    sign_out current_user
    redirect_to "/"
  end
end
