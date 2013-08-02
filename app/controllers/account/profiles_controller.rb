class Account::ProfilesController < ApplicationController
  include ProfilesHelper
  # GET /profiles
  # GET /profiles.json

  before_filter :authenticate_user!
  before_filter :check_profile, :except => ['edit', 'edit_special_acts']

  def index
    @profiles = Profile.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @profiles }
    end
  end

  def skip_step_3
    profile = current_user.profile
    profile.step = 3
    profile.save(:validate => false)

    if profile.active?
      profile.user.first_time_login!
    end

    redirect_to root_path
  end

  # GET /profiles/1
  # GET /profiles/1.json
  def show
    render :json => profile_to_json(current_user.profile)
  end

  # GET /profiles/new
  # GET /profiles/new.json
  def new
    @profile = Profile.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @profile }
    end
  end

  # GET /profiles/1/edit
  def edit
    if params[:tab].blank?
      params[:tab] = 'text'
    end

    if current_user.profile.nil?
      current_user.create_profile
    end

    @profile = current_user.profile

    if params[:step]
      render "step_#{params[:step]}"
      return 
    else
      return if check_profile
      render 'edit'
    end
  end

  def create
    @profile = Profile.new(params[:profile])

    respond_to do |format|
      if @profile.save
        format.html { redirect_to @profile, notice: 'Profile was successfully created.' }
        format.json { render json: @profile, status: :created, location: @profile }
      else
        format.html { 
          render_edit
        }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /profiles/1
  # PUT /profiles/1.json
  def update
    @profile = current_user.profile

    current_user.usracts.create

    if @profile.update_attributes(params[:profile])
      if request.xhr?
        render :nothing => true, :status => 200, :content_type => 'text/html'
      else
        if @profile.active?
          if params[:profile][:step]
            @profile.user.first_time_login!
          end
          redirect_to edit_account_profile_path(:tab => params[:tab]), :notice => 'Your profile has been saved!'
          return
        else
          redirect_to edit_account_profile_path(:step => @profile.step + 1, :tab => params[:tab])
          return
        end
      end

    else
      if request.xhr?
        render :json => @profile.errors, :status => :unprocessable_entity
      else
        if @profile.active?
          render 'edit'
          return
        else
          render "step_#{@profile.step}"
        end
      end
    end
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    @profile = Profile.find(params[:id])
    @profile.destroy

    respond_to do |format|
      format.html { redirect_to profiles_url }
      format.json { head :ok }
    end
  end
  

  def edit_special_acts
    @profile = current_user.profile
    render :layout => 'iframe_layout'
  end
end

