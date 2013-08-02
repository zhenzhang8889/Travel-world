module ApplicationHelper
  def super_subscribe_to(channel)
    subscription = PrivatePub.subscription(:channel => channel)
    raw("PrivatePub.sign(#{subscription.to_json});")
  end

  def profile_pic(profile)
    if profile and @profile.prof_avatar and @profile.prof_avatar.data
      @profile.prof_avatar.data.url(:medium)
    else
      "avatar_medium_missing-200px.png" 
    end
  end
end
