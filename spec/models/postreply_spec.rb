# == Schema Information
#
# Table name: postreplies
#
#  id         :integer          not null, primary key
#  body       :text
#  post_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#

require 'spec_helper'

describe Postreply do
  pending "add some examples to (or delete) #{__FILE__}"
end
