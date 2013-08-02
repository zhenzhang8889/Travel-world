class Account::AvatarsController < ApplicationController
  include ProfilesHelper

  def create
    @profile = current_user.profile

    if @profile.update_attributes(params[:profile])
      puts profile_to_json(@profile)
      
      return render :json => profile_to_json(@profile), :status => :created
    else
      # return render :json => profile_to_json(@profile)
      return render json: @profile.errors, status: :unprocessable_entity
      # render :partial => 'profiles/avatar/upload', :locals => {:profile => @profile}
    end
  end

  def update
    @avatar = current_user.profile.pre_prof_avatar

    @avatar.attributes = params[:prof_avatar]

    @avatar.data = @avatar.data
    @avatar.p_state = 'active'

    current_user.profile.prof_avatar.try(:destroy)

    if @avatar.save
      current_user.avatar = current_user.profile.prof_avatar.data
      if current_user.save
        return render :nothing => true, :status => :created
      end
    end

    return render :action => :edit, :layout => false
  end


  # def can_crop avatar
    # return true

    # file = Tempfile.new('avatar', :encoding => 'ascii-8bit')
    # begin
    #   file << RestClient.get(avatar.to_s)
    #   geo = Paperclip::Geometry.from_file(file)
    #   return (geo.width > 360 && geo.height > 360)
    # rescue
    #   false
    # ensure
    #   file.close
    #   file.unlink   # deletes the temp file
    # end

  # end
end
