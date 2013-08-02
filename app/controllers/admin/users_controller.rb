class Admin::UsersController < Admin::BaseController
  def index
    params[:search] ||= {}
    unless params[:search][:meta_sort]
      params[:search][:meta_sort] = 'created_at.desc'
    end
    
    @search = User.search(params[:search])
    @users = @search.paginate(:page => params[:page])
  end

  def disable
    @user = User.find(params[:id])
    @user.active = false
    @user.save(:validate => false)
    redirect_to admin_users_path, :notice => 'User Suspended!'
  end

  def active
    @user = User.find(params[:id])
    @user.active = true
    @user.save(:validate => false)
    redirect_to admin_users_path, :notice => 'User Actived!'
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(params[:user])
      redirect_to admin_users_path
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      redirect_to admin_users_path, :notice => 'Destroyed!!'
    else
      redirect_to admin_users_path, :error => 'Failed to destroy user!!'
    end    
  end
end