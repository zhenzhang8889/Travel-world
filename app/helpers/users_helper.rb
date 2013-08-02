module UsersHelper
  def user_json
    {:methods => [:service_name, :area_name, :full_name, :name, :imageUrlMedium, :service_tag, :imageUrlSmall, :categoryName],
     :include => {:category => {:include => []}, :profile => {:include => [:area, :service]}}
    }
  end
end
