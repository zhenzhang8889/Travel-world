class AlterUsersAddScore < ActiveRecord::Migration
  def up
    add_column :users, :score, :integer
  end
    
  def down
    remove_column :users, :score
  end
end
