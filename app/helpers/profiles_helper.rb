module ProfilesHelper
  def profile_to_json profile
    unless profile.nil?
      return profile.to_json(:include => {:area => {}, :service => {}, :address => {}, :activities => {}, :prof_avatar => {:methods => [:medium_url]}, :pre_prof_avatar => {:methods => [:medium_url]}}, :methods => [:special_act_list])
    end
    nil
  end
end
