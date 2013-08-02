class Account::SpecialActsController < ApplicationController
  def create

    if !params[:special_act].blank?
      @profile = current_user.profile
      @profile.special_act_list = (current_user.profile.special_acts.map(&:name) + [params[:special_act]]).join(',')
      @profile.save(:validate => false)

      render :partial => 'account/profiles/edit_special_acts', :locals => {:profile => @profile}, :status => 200, :content_type => 'text/html'
      return
    else
      render :nothing => true, :status => 404
    end
  end
  
  def destroy
    @special_act = current_user.profile.special_acts.find(params[:id])

    if @special_act.delete
      render :nothing => true, :status => 200, :content_type => 'text/html'
    else
      render :nothing => true
    end
  end
end