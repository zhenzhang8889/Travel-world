class AlterBadgesAddCategoryBadgeId < ActiveRecord::Migration
  def up
    add_column :badges, :category_badge_id, :integer
  end

  def down
    remove_column :badges, :category_badge_id
  end
end
