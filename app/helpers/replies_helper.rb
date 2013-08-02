module RepliesHelper
  def reply_to_json reply
    reply.to_json(:include => {:original_lead => {:include => {:user => {:methods => [:imageUrlMedium, :name]}}}})
  end
end
