class SeedCategoryBadges < ActiveRecord::Migration
  def up
    CategoryBadge.find_or_create_by_name(name: 'Local Tourism')
    CategoryBadge.find_or_create_by_name(name: 'Ecotourism')
  end

  def down
    CategoryBadge.destroy_all()
  end
end
