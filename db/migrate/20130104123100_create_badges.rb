class CreateBadges < ActiveRecord::Migration
  def change
    create_table :badges do |t|
      t.string :name
      t.integer :point
      t.boolean :is_active

      t.timestamps
    end
  end
end
