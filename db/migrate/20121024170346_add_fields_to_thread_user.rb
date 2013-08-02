class AddFieldsToThreadUser < ActiveRecord::Migration
  def change
    add_column :thread_users, :user_id, :integer
    add_column :thread_users, :message_thread_id, :integer
  end
end
