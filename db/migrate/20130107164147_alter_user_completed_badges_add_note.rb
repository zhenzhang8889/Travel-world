class AlterUserCompletedBadgesAddNote < ActiveRecord::Migration

  def up
    add_column :user_completed_badges, :note, :string
  end

  def down
    remove_column :user_completed_badges, :note
  end

end
