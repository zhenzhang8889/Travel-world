class AddUserIdToQuickMessage < ActiveRecord::Migration
  def change
    add_column :quick_messages, :user_id, :integer
  end
end
