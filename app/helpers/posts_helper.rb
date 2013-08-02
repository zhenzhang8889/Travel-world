module PostsHelper
  include UsersHelper

  def post_json
    {:include => {
        :postreplies => {:include => {:user => user_json}},
        :user => user_json,
        :refer_tos => user_json
      },
      :methods => [:medium_data_url]
    }
  end

  def post_to_json post
    post.to_json(
      :include => {
        :postreplies => {:include => {:user => user_json}},
        :user => user_json,
        :refer_tos => user_json
      }, 
      :methods => [:medium_data_url])
  end
end
