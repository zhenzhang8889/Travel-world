require 'spec_helper'

describe MailerController do

  describe "GET 'send'" do
    it "returns http success" do
      get 'send'
      response.should be_success
    end
  end

end
