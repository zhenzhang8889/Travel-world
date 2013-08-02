class AlterUsersAddIsEnabled < ActiveRecord::Migration
  def up
    add_column :users, :is_enabled, :boolean
  end

  def down
    remove_column :users, :is_enabled
  end
end
