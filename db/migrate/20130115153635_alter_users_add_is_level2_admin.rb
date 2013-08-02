class AlterUsersAddIsLevel2Admin < ActiveRecord::Migration
  
  def up
    add_column :users, :is_level2_admin, :boolean
  end

  def down
    remove_column :users, :is_level2_admin
  end

end
