module RefertosHelper
  include UsersHelper
  include PostsHelper

  def referto_post_json
    {:include => {:from => user_json, :referable => post_json}}
  end

  def referto_user_json
    {:include => {:from => user_json, :referable => user_json}}
  end

end

# :methods => [:service_name, :area_name, :full_name, :name, :imageUrlMedium, :service_tag, :imageUrlSmall, :categoryName],
