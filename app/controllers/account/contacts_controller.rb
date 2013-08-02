class Account::ContactsController < ApplicationController
  include UsersHelper

  def index
    return :json => current_user.users.to_json(user_json), :status => :ok
  end
end
