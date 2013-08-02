class AddUserIdToPostreplies < ActiveRecord::Migration
  def change
    add_column :postreplies, :user_id, :integer
  end
end
