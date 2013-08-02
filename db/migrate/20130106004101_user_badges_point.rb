class UserBadgesPoint < ActiveRecord::Migration

  def up
    remove_column :users, :score
    create_table :user_completed_badges do |t|
      t.integer :badge_id, :user_id
    end
    add_index :user_completed_badges, :badge_id
    add_index :user_completed_badges, :user_id
  end

  def down
    add_column :users, :score, :integer
    drop_table :user_completed_badges
  end
  
end
