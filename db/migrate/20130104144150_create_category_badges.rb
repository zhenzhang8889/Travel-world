class CreateCategoryBadges < ActiveRecord::Migration
  def change
    create_table :category_badges do |t|
      t.string :name

      t.timestamps
    end
  end
end
