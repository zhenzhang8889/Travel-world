class CreateLocationGroups < ActiveRecord::Migration
  def change
    create_table :location_groups do |t|
      t.string :code
      t.string :name
      t.integer :lorder, :default => 99

      t.timestamps
    end
  end
end
